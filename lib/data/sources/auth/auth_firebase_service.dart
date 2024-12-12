import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copyify/core/constants/app_urls.dart';
import 'package:copyify/data/models/auth/create_user_req.dart';
import 'package:copyify/data/models/auth/login_user_req.dart';
import 'package:copyify/data/models/auth/user.dart';
import 'package:copyify/domain/entities/auth/user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseService{
  Future<Either> register(CreateUserReq createUserReq);

  Future<Either> login(LoginUserRequest loginUserRequest);

  Future<Either> getUser();
}

class AuthFirebaseServiceImp extends AuthFirebaseService{
  @override
  Future<Either> login(LoginUserRequest loginUserRequest) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginUserRequest.email,
          password: loginUserRequest.password
      );

      return const Right("Login was Successful");

    }on FirebaseAuthException catch(e){
      String message = "";
      if (e.code == 'invalid-email'){
        message = "User not found";
      }else if (e.code == 'invalid-credential'){
        message = "Password is incorrect";
      }
      print("fuck this hurts$message");
      return Left(message);
    }
  }

  @override
  Future<Either> register(CreateUserReq createUserReq) async{
    try{
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email,
          password: createUserReq.password
      );
      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set(
          {
            'name': createUserReq.fullName,
            'email': data.user?.email
          }
      );
      return const Right("Register was Successful");

    }on FirebaseAuthException catch(e){
      String message = "";
      if(e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'Account already exists';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async{
    try{
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore.collection("Users").doc(
          firebaseAuth.currentUser?.uid
      ).get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageUrl = firebaseAuth.currentUser?.photoURL ?? AppURLs.defaultImage;
      UserEntity userEntity = userModel.toUserEnitiy();
      return Right(userEntity);
    }catch(e){
      return const Left("An error occurred");
    }

  }

}