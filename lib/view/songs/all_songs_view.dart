import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common_widget/all_song_row.dart';
import 'package:music_player/view/main_player/main_player_view.dart';
import 'package:music_player/view_model/all_songs_view_model.dart';
import 'package:music_player/models/song_model.dart';

class AllSongsView extends StatelessWidget {
  const AllSongsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllSongsViewModel allVM = Get.put(AllSongsViewModel());

    return Scaffold(
      body: Obx(
            () => allVM.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: allVM.allList.length,
          itemBuilder: (context, index) {
            var song = allVM.allList[index];

            return AllSongRow(
              song: song,
              onPressed: () {
                // Xử lý sự kiện khi người dùng nhấn vào hàng bài hát
              },
              onPressedPlay: () {
                Get.to(() => MainPlayerView(song: song));
              },
            );
          },
        ),
      ),
    );
  }
}
