import 'package:copyify/domain/entities/song/song.dart';

abstract class NewsSongsState{}

class NewsSongsLoading extends NewsSongsState{}

class NewsSongsLoaded extends NewsSongsState{
  final List<SongEntity> songs;

  NewsSongsLoaded({required this.songs});
}

class NewsSongsLoadingFailure extends NewsSongsState{}