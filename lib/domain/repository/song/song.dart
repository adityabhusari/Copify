import 'package:dartz/dartz.dart';

abstract class SongRepository{
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addRemoveFavSong(String songId);
  Future<bool> isFavSong(String songId);
  Future<Either> getUserFavSongs();

}