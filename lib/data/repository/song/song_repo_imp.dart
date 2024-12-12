import 'package:copyify/data/sources/song/song_firebase_service.dart';
import 'package:copyify/domain/repository/song/song.dart';
import 'package:copyify/service_locator.dart';
import 'package:dartz/dartz.dart';

class SongRepositoryImp extends SongRepository{
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async{
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addRemoveFavSong(String songId) async{
    return await sl<SongFirebaseService>().addRemoveFavSong(songId);
  }

  @override
  Future<bool> isFavSong(String songId) async{
    return await sl<SongFirebaseService>().isFavSong(songId);
  }

  @override
  Future<Either> getUserFavSongs() async{
    return await sl<SongFirebaseService>().getUserFavSongs();
  }

}