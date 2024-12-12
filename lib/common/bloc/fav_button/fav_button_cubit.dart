import 'dart:ffi';

import 'package:copyify/common/bloc/fav_button/fav_button_state.dart';
import 'package:copyify/domain/usecases/song/add_remove_fav_songs.dart';
import 'package:copyify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavButtonCubit extends Cubit<FavButtonState>{
  FavButtonCubit() : super(FavButtonInitial());

  Future<void> favButtonUpdated(String songId) async{
    var result = await sl<AddRemoveFavSongUseCase>().call(
      params: songId
    );

    result.fold(
            (l){},
            (isFav){
              emit(
                FavButtonUpdated(isFav: isFav)
              );
            }
    );
  }


}