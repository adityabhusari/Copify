import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity{
  final String title;
  final String artists;
  final num duration;
  final Timestamp releaseDate;
  final bool isFav;
  final String songId;

  SongEntity({
    required this.title,
    required this.artists,
    required this.duration,
    required this.releaseDate,
    required this.isFav,
    required this.songId
  });
}