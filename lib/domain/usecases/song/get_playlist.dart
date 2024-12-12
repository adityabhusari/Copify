import 'package:copyify/core/usecase/usecase.dart';
import 'package:copyify/domain/repository/song/song.dart';
import 'package:copyify/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetPlaylistUseCase implements UseCase<Either, dynamic>{
  @override
  Future<Either> call({params}) async{
    return await sl<SongRepository>().getPlayList();
  }

}