import 'package:flutter/material.dart';
class TrackModel {
  String name, artistName, albumName,image;
  int playbackSeconds;
  Color color;

  TrackModel(
      {required this.name,
      required this.artistName,
      required this.albumName,
      required this.image,
      required this.color,
      required this.playbackSeconds});

  factory TrackModel.fromJson(Map<String, dynamic> map) {
    return TrackModel(
      name: map['name'],
      artistName: map['artistName'],
      albumName: map['albumName'],
      playbackSeconds: map['playbackSeconds'],
      image: "assets/song1.jpg",
      color: Colors.red,
    );
  }
}