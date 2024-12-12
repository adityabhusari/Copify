import 'package:copyify/core/usecase/usecase.dart';
import 'package:copyify/domain/repository/song/song.dart';
import 'package:copyify/service_locator.dart';
import 'package:dartz/dartz.dart';

class AddRemoveFavSongUseCase implements UseCase<Either, String>{
  @override
  Future<Either> call({String ? params}) async {
    return await sl<SongRepository>().addRemoveFavSong(params!);
  }

}