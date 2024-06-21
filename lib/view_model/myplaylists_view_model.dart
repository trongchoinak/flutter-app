import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:music_player/models/song_model.dart';

class MyplaylistsViewModel extends GetxController {
  RxList<Song> allList = <Song>[].obs;
  late SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    final List<String>? savedSongs = _prefs.getStringList('myPlaylist');
    if (savedSongs != null) {
      allList.assignAll(savedSongs.map((json) => Song.fromJson(jsonDecode(json))).toList());
    }
  }

  Future<void> _saveData() async {
    List<String> jsonStringList = allList.map((song) => jsonEncode(song.toJson())).toList();
    await _prefs.setStringList('myPlaylist', jsonStringList);
  }

  void addToPlaylist(Song song) {
    if (!allList.contains(song)) {
      allList.add(song);
      _saveData();
    }
  }

  void removeFromPlaylist(Song song) {
    allList.remove(song);
    _saveData();
  }
}
