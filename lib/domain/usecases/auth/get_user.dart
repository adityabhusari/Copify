import 'package:copyify/core/usecase/usecase.dart';
import 'package:copyify/domain/repository/auth/auth.dart';
import 'package:copyify/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase implements UseCase<Either, dynamic>{
  @override
  Future<Either> call({params}) async{
    // TODO: implement call
    return await sl<AuthRepository>().getUser();
  }


}