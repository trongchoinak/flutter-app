import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_player/view_model/all_songs_view_model.dart';
import 'package:music_player/models/song_model.dart';

class HomeViewModel extends GetxController {
    final AllSongsViewModel _allSongsViewModel = Get.find();

    var txtSearch = TextEditingController().obs;
    var searchResult = <Song>[].obs;

    List<Song> get hostRecommendedArr => _allSongsViewModel.allList; // Giả sử lấy tất cả bài hát làm recommended

    void performSearch() {
        String query = txtSearch.value.text.toLowerCase();
        if (query.isEmpty) {
            searchResult.clear();
        } else {
            searchResult.assignAll(_allSongsViewModel.allList.where((song) =>
            song.title.toLowerCase().contains(query) ||
                song.album.toLowerCase().contains(query) ||
                song.artist.toLowerCase().contains(query)));
        }
    }
}
