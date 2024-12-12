

import 'package:copyify/common/helpers/is_dark_extension.dart';
import 'package:copyify/core/configs/theme/app_colors.dart';
import 'package:copyify/core/constants/app_urls.dart';
import 'package:copyify/domain/entities/song/song.dart';
import 'package:copyify/presentation/home/bloc/news_songs_cubit.dart';
import 'package:copyify/presentation/home/bloc/news_songs_state.dart';
import 'package:copyify/presentation/song_player/pages/song_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsSongsCubit()..getNewsSongs(),
        child: SizedBox(
          height: 200,
          child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
            builder: (context, state) {
              if (state is NewsSongsLoading){
                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()
                );
              }

              if (state is NewsSongsLoaded){
                return _songs(state.songs);
              }

              return Container();
            },
          ),
        ),
    );
  }

  Widget _songs(List<SongEntity> songs){
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final song = songs[index];
          final imageUrl = '${AppURLs.supaStorage}${song.artists} - ${song.title}.jpg';
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SongPlayer(songEntity: song,),));
            },
            child: SizedBox(
              height: 160,
              width: 160,
              child: ClipRRect(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: NetworkImage(
                                imageUrl,
                              )
                          )
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: context.isDark ? Colors.white70 : AppColors.darkGray,
                            ),
                            transform: Matrix4.translationValues(0, 5, 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.isDark ? AppColors.darkGray : Colors.white70 ,

                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      songs[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      songs[index].artists,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 15,
          );
        },
        itemCount: songs.length
    );
  }
}
