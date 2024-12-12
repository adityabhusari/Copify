import 'package:copyify/data/repository/auth/auth_repo_imp.dart';
import 'package:copyify/data/repository/song/song_repo_imp.dart';
import 'package:copyify/data/sources/auth/auth_firebase_service.dart';
import 'package:copyify/data/sources/song/song_firebase_service.dart';
import 'package:copyify/domain/repository/auth/auth.dart';
import 'package:copyify/domain/repository/song/song.dart';
import 'package:copyify/domain/usecases/auth/get_user.dart';
import 'package:copyify/domain/usecases/auth/login.dart';
import 'package:copyify/domain/usecases/auth/register.dart';
import 'package:copyify/domain/usecases/song/add_remove_fav_songs.dart';
import 'package:copyify/domain/usecases/song/get_news_song.dart';
import 'package:copyify/domain/usecases/song/get_playlist.dart';
import 'package:copyify/domain/usecases/song/get_user_fav_songs.dart';
import 'package:copyify/domain/usecases/song/is_song_fav.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImp()
  );

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImp()
  );

  sl.registerSingleton<RegisterUseCase>(
    RegisterUseCase()
  );

  sl.registerSingleton<LoginUseCase>(
      LoginUseCase()
  );

  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImp()
  );

  sl.registerSingleton<SongRepository>(
      SongRepositoryImp()
  );

  sl.registerSingleton<GetNewsSongUseCase>(
    GetNewsSongUseCase()
  );

  sl.registerSingleton<GetPlaylistUseCase>(
      GetPlaylistUseCase()
  );

  sl.registerSingleton<AddRemoveFavSongUseCase>(
      AddRemoveFavSongUseCase()
  );

  sl.registerSingleton<isFavSongUseCase>(
      isFavSongUseCase()
  );

  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );

  sl.registerSingleton<GetUserFavSongsUseCase>(
      GetUserFavSongsUseCase()
  );
}