import 'package:copyify/domain/usecases/song/get_news_song.dart';
import 'package:copyify/presentation/home/bloc/news_songs_state.dart';
import 'package:copyify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSongsCubit extends Cubit<NewsSongsState>{
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongUseCase>().call();

    returnedSongs.fold(
            (l) {
              emit(NewsSongsLoadingFailure());
            } , 
            (data) {
              emit(NewsSongsLoaded(songs: data));
            });
  }

}