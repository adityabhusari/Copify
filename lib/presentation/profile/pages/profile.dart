import 'package:copyify/common/helpers/is_dark_extension.dart';
import 'package:copyify/common/widgets/appbar/appbar.dart';
import 'package:copyify/common/widgets/fav_button/fav_button.dart';
import 'package:copyify/core/configs/theme/app_colors.dart';
import 'package:copyify/core/constants/app_urls.dart';
import 'package:copyify/presentation/profile/bloc/fav_songs_cubit.dart';
import 'package:copyify/presentation/profile/bloc/fav_songs_state.dart';
import 'package:copyify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:copyify/presentation/profile/bloc/profile_info_state.dart';
import 'package:copyify/presentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        bgColor: AppColors.darkGray,
        title: Text("Profile"),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _profileBar(context),
            SizedBox(height: 20,),
            _favSongs(context)
        ],
      ),
    );
  }

  Widget _profileBar(BuildContext context){
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 3.4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.isDark ? AppColors.darkGray : Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)
            )
          ),
          child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
              if (state is ProfileInfoLoading){
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProfileInfoLoaded){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Container(
                        height: 70,
                        width: 90,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                              state.userEntity.imageUrl!
                            )
                          ),
                          shape: BoxShape.circle
                        ),
                      ),
                    SizedBox(height: 15,),
                    Text(state.userEntity.email!, style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10,),
                    Text(state.userEntity.fullName!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  ],
                );
              }
              if (state is ProfileInfoFailure){
                return Text(
                  "Please try again"
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _favSongs(BuildContext context){
    return BlocProvider(
        create: (context) => FavSongsCubit()..getUserFavSongs(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("FAVORITE SONGS", style: TextStyle(fontSize: 16)),
              SizedBox(height: 15,),
              BlocBuilder<FavSongsCubit, FavSongsState>(
                builder: (context, state) {
                  if (state is FavSongsLoading){
                    return CircularProgressIndicator();
                  }
                  if (state is FavSongsLoaded){
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final song = state.favSongs[index];
                          final imageUrl = '${AppURLs.supaStorage}${song.artists} - ${song.title}.jpg';
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SongPlayer(songEntity: song),));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              imageUrl
                                            )
                                        )
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          song.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          song.artists,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        song.duration.toString().replaceAll('.', ':'),
                                        style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 15,),
                                    FavButton(
                                        key: UniqueKey(),
                                        songEntity: song,
                                        function: () {
                                          context.read<FavSongsCubit>().removeFromFavs(index);
                                        }
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 20,),
                        itemCount: state.favSongs.length);
                  }
                  if (state is FavSongsFailure){
                    return Text("Please try again");
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
    );
  }
}
