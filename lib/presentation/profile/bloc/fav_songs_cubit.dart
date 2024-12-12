import 'dart:ffi';

import 'package:copyify/domain/entities/song/song.dart';
import 'package:copyify/domain/usecases/song/get_playlist.dart';
import 'package:copyify/domain/usecases/song/get_user_fav_songs.dart';
import 'package:copyify/presentation/profile/bloc/fav_songs_state.dart';
import 'package:copyify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavSongsCubit extends Cubit<FavSongsState>{

  FavSongsCubit() : super(FavSongsLoading());

  List<SongEntity> favSongs = [];

  Future<void> getUserFavSongs() async{
    var result = await sl<GetUserFavSongsUseCase>().call();
    result.fold(
            (l){
              emit(
                FavSongsFailure()
              );
            }, 
            (r){
              favSongs = r;
              emit(
                FavSongsLoaded(favSongs: favSongs)
              );
            });
    
  }

  Future<void> removeFromFavs(int index) async{
    favSongs.removeAt(
      index
    );
    emit(
        FavSongsLoaded(favSongs: favSongs)
    );
  }

}