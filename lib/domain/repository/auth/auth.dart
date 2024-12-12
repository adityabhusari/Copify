
import 'package:copyify/data/models/auth/create_user_req.dart';
import 'package:copyify/data/models/auth/login_user_req.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository{

  Future<Either> register(CreateUserReq createUserReq);

  Future<Either> login(LoginUserRequest loginUserRequest);

  Future<Either> getUser();
}