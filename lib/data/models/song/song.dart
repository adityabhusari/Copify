import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copyify/domain/entities/song/song.dart';

class SongModel{
  String ? title;
  String ? artists;
  num ? duration;
  Timestamp ? releaseDate;
  bool? isFav;
  String ? songId;

  SongModel({
    required this.title,
    required this.artists,
    required this.duration,
    required this.releaseDate,
    required this.isFav,
    required this.songId
  });

  SongModel.fromJson(Map<String, dynamic> data){
    title = data['title'];
    artists = data['artists'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
   }
}

extension SongModelX on SongModel{
  SongEntity toSongEnitiy() {
    return SongEntity(title: title!, artists: artists!, duration: duration!, releaseDate: releaseDate!, isFav: isFav!, songId: songId!);
  }
}