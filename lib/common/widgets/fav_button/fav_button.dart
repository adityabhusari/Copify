import 'package:copyify/common/bloc/fav_button/fav_button_cubit.dart';
import 'package:copyify/common/bloc/fav_button/fav_button_state.dart';
import 'package:copyify/core/configs/theme/app_colors.dart';
import 'package:copyify/domain/entities/song/song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  FavButton({
    required this.songEntity,
    this.function,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FavButtonCubit(),
        child: BlocBuilder<FavButtonCubit, FavButtonState>(
          builder: (context, state) {
            if (state is FavButtonInitial){
              return IconButton(
                  onPressed: () async{
                    await context.read<FavButtonCubit>().favButtonUpdated(songEntity.songId);
                    if (function != null){
                      function!();
                    }
                  },
                  icon: Icon(
                    songEntity.isFav ? Icons.favorite : Icons.favorite_outline,
                    color: AppColors.darkGray,
                  )
              );
            }
            if (state is FavButtonUpdated){
              return IconButton(
                  onPressed: () async{
                    context.read<FavButtonCubit>().favButtonUpdated(songEntity.songId);
                  },
                  icon: Icon(
                    state.isFav ? Icons.favorite : Icons.favorite_outline,
                    color: AppColors.darkGray,
                  )
              );
            }

            return Container();
          },
        ),
    );
  }
}
