// lib/models/song_model.dart
import 'dart:convert';

class Song {
  final String id;
  final String title;
  final String album;
  final String artist;
  final String source;
  final String image;
  final int duration;
  final bool favorite;
  final int counter;
  final int replay;

  Song({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.source,
    required this.image,
    required this.duration,
    required this.favorite,
    required this.counter,
    required this.replay,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      album: json['album'],
      artist: json['artist'],
      source: json['source'],
      image: json['image'],
      duration: json['duration'],
      favorite: json['favorite'] == "true",
      counter: json['counter'],
      replay: json['replay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'album': album,
      'artist': artist,
      'source': source,
      'image': image,
      'duration': duration,
      'favorite': favorite.toString(),
      'counter': counter,
      'replay': replay,
    };
  }
}
