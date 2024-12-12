import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copyify/data/models/song/song.dart';
import 'package:copyify/domain/entities/song/song.dart';
import 'package:copyify/domain/usecases/song/is_song_fav.dart';
import 'package:copyify/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SongFirebaseService{
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addRemoveFavSong(String songId);
  Future<bool> isFavSong(String songId);
  Future<Either> getUserFavSongs();
}

class SongFirebaseServiceImp extends SongFirebaseService{

  @override
  Future<Either> getNewsSongs() async{
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFav = await sl<isFavSongUseCase>().call(
          params: element.reference.id
        );
        songModel.isFav = isFav;
        songModel.songId = element.reference.id;
        songs.add(
            songModel.toSongEnitiy()
        );
      }

      return Right(songs);
    }catch (e){
      return const Left('An error occured, please try again.');
    }

  }

  @override
  Future<Either> getPlayList() async{
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFav = await sl<isFavSongUseCase>().call(
            params: element.reference.id
        );
        songModel.isFav = isFav;
        songModel.songId = element.reference.id;
        songs.add(
            songModel.toSongEnitiy()
        );
      }
      return Right(songs);
    }catch (e){
      return const Left('An error occured, please try again.');
    }
  }

  @override
  Future<Either> addRemoveFavSong(String songId) async {
    try{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFav;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favSongs = await firebaseFirestore.collection('Users').doc(uId).collection('Favorites').where('songId', isEqualTo: songId).get();
      if (favSongs.docs.isNotEmpty){
        await favSongs.docs.first.reference.delete();
        isFav = false;
      }else{
        await firebaseFirestore.collection('Users').doc(uId).collection('Favorites').add({
          'songId': songId,
          'addedDate': Timestamp.now()
        });
        isFav = true;
      }
      return Right(isFav);
    }catch(e){
      return Left('An error occured');
    }


  }

  @override
  Future<bool> isFavSong(String songId) async{
    try{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favSongs = await firebaseFirestore.collection('Users').doc(uId).collection('Favorites').where('songId', isEqualTo: songId).get();
      if (favSongs.docs.isNotEmpty){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }

  @override
  Future<Either> getUserFavSongs() async {
    try{
      List<SongEntity> favSongs = [];
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favSnap = await firebaseFirestore.collection("Users").doc(uId).collection("Favorites").get();
      for (var element in favSnap.docs) {
          String songId = element['songId'];
          var song = await firebaseFirestore.collection('Songs').doc(songId).get();
          SongModel songModel = SongModel.fromJson(song.data()!);
          songModel.isFav = true;
          songModel.songId = songId;
          favSongs.add(
            songModel.toSongEnitiy()
          );
      }
      return Right(favSongs);
    }catch(e){
      return Left("An error occurred");
    }
  }

}