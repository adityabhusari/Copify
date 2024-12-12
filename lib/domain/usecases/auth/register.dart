import 'package:copyify/core/usecase/usecase.dart';
import 'package:copyify/data/models/auth/create_user_req.dart';
import 'package:copyify/domain/repository/auth/auth.dart';
import 'package:copyify/service_locator.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements UseCase<Either, CreateUserReq>{
  @override
  Future<Either> call({CreateUserReq ? params}) async{
    return await sl<AuthRepository>().register(params!);
  }
  
}