import 'package:copyify/core/usecase/usecase.dart';
import 'package:copyify/data/models/auth/create_user_req.dart';
import 'package:copyify/data/models/auth/login_user_req.dart';
import 'package:copyify/domain/repository/auth/auth.dart';
import 'package:copyify/service_locator.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements UseCase<Either, LoginUserRequest>{
  @override
  Future<Either> call({LoginUserRequest ? params}) async{
    return await sl<AuthRepository>().login(params!);
  }

}