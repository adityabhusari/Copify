import 'package:copyify/domain/usecases/song/get_news_song.dart';
import 'package:copyify/domain/usecases/song/get_playlist.dart';
import 'package:copyify/presentation/home/bloc/playlist_state.dart';
import 'package:copyify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayListCubit extends Cubit<PlayListState>{
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlaylistUseCase>().call();

    returnedSongs.fold(
            (l) {
          emit(PlayListLoadingFailure());
        } ,
            (data) {
          emit(PlayListLoaded(songs: data));
        });
  }

}