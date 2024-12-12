import 'package:copyify/common/widgets/appbar/appbar.dart';
import 'package:copyify/common/widgets/fav_button/fav_button.dart';
import 'package:copyify/core/configs/theme/app_colors.dart';
import 'package:copyify/core/constants/app_urls.dart';
import 'package:copyify/domain/entities/song/song.dart';
import 'package:copyify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:copyify/presentation/song_player/bloc/song_player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongPlayer extends StatelessWidget {
  SongEntity songEntity;
  SongPlayer({
    required this.songEntity,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('${AppURLs.songsSupaStorage}${songEntity.artists} - ${songEntity.title}.mp3');
    return Scaffold(
      appBar: BasicAppBar(
        title: Text("Now Playing", style: TextStyle(fontSize: 18)),
        action: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_rounded
            )
        ),
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()..loadSong(
            '${AppURLs.songsSupaStorage}${songEntity.artists} - ${songEntity.title}.mp3'
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    _songCover(context),
                    SizedBox(height: 20,),
                    _songDetail(context),
                    SizedBox(height: 30,),
                    _songPlayer(context)
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context){
      final imageUrl = '${AppURLs.supaStorage}${songEntity.artists} - ${songEntity.title}.jpg';
      return Container(
        height: MediaQuery.sizeOf(context).height / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              imageUrl
            )
          )
        ),
      );
  }

  Widget _songDetail(BuildContext context){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songEntity.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                songEntity.artists,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16
                ),
              ),
            ],
          ),
          FavButton(songEntity: songEntity)
        ],
      );
  }

  Widget _songPlayer(BuildContext context){
    return BlocBuilder<SongPlayerCubit, SongPlayerStates>(
        builder: (context, state) {
          if (state is SongPlayerLoading){
            return CircularProgressIndicator();
          }
          if (state is SongPlayerLoaded){
            return Column(
              children: [
                Slider(
                    value: context.read<SongPlayerCubit>().songPosition.inMinutes.toDouble(),
                    min: 0.0,
                    max: context.read<SongPlayerCubit>().songDuration.inMinutes.toDouble(),
                    onChanged: (value) {
                      
                    }
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Text(
                        formatDuration(
                          context.read<SongPlayerCubit>().songPosition
                        )
                      ),
                    Text(
                        formatDuration(
                            context.read<SongPlayerCubit>().songDuration
                        )
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    context.read<SongPlayerCubit>().playPause();
                  },
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary
                    ),
                    child: Icon(
                        context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow
                    ),
                  ),
                )
              ],
            );
          }
          return Container();
        },
    );
  }

  String formatDuration(Duration duration){
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
