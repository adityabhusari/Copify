import 'package:copyify/core/usecase/usecase.dart';
import 'package:copyify/domain/repository/song/song.dart';
import 'package:copyify/service_locator.dart';
import 'package:dartz/dartz.dart';

class isFavSongUseCase implements UseCase<bool, String>{
  @override
  Future<bool> call({String ? params}) async {
    return await sl<SongRepository>().isFavSong(params!);
  }

}