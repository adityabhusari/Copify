

import 'package:copyify/common/helpers/is_dark_extension.dart';
import 'package:copyify/common/widgets/fav_button/fav_button.dart';
import 'package:copyify/core/configs/theme/app_colors.dart';
import 'package:copyify/domain/entities/song/song.dart';
import 'package:copyify/presentation/home/bloc/playlist_cubit.dart';
import 'package:copyify/presentation/home/bloc/playlist_state.dart';
import 'package:copyify/presentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayList extends StatelessWidget {
   PlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PlayListCubit()..getPlayList(),
        child: BlocBuilder<PlayListCubit, PlayListState>(
          builder: (context, state) {
            if (state is PlayListLoading){
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()
              );
            }
            if (state is PlayListLoaded){
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 16
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Playlist",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                        ),
                        Text(
                            "See More",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            color: Colors.white60
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    _songs(state.songs)
                  ],
                ),
              );
            }
            return Container();
          },
        ),
    );
  }
  Widget _songs(List<SongEntity> songs){
      return SizedBox(
        height: 500,
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SongPlayer(songEntity: songs[index]),));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.isDark ? AppColors.darkGray : const Color(0xffE6E6E6)
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: context.isDark ? const Color(0xff959595) : const Color(0xff555555) ,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              songs[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text(
                              songs[index].artists,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            songs[index].duration.toString().replaceAll('.', ':')
                        ),
                        const SizedBox(width: 20,),
                        FavButton(
                            songEntity: songs[index],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 20,),
            itemCount: songs.length
        ),
      );
  }
}
