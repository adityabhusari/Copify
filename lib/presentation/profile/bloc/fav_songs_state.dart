import 'package:copyify/domain/entities/song/song.dart';

abstract class FavSongsState {}

class FavSongsLoading extends FavSongsState{}

class FavSongsLoaded extends FavSongsState{
  final List<SongEntity> favSongs;
  FavSongsLoaded({required this.favSongs});
}

class FavSongsFailure extends FavSongsState{}