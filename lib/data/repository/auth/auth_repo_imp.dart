import 'package:copyify/data/models/auth/create_user_req.dart';
import 'package:copyify/data/models/auth/login_user_req.dart';
import 'package:copyify/data/sources/auth/auth_firebase_service.dart';
import 'package:copyify/domain/repository/auth/auth.dart';
import 'package:copyify/service_locator.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImp extends AuthRepository{
  @override
  Future<Either> login(LoginUserRequest loginUserRequest) async{
    return await sl<AuthFirebaseService>().login(loginUserRequest);
  }

  @override
  Future<Either> register(CreateUserReq createUserReq) async{
    return await sl<AuthFirebaseService>().register(createUserReq);
  }

  @override
  Future<Either> getUser() async{
    return await sl<AuthFirebaseService>().getUser();
  }

}