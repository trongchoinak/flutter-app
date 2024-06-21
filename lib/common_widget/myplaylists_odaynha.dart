import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/main_player/main_player_view.dart';
import 'package:music_player/view_model/myplaylists_view_model.dart';

class MyPlaylistsOdayne extends StatelessWidget {
  final MyplaylistsViewModel myPlaylistsVM = Get.find();

  MyPlaylistsOdayne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (myPlaylistsVM.allList.isEmpty) {
        return Center(
          child: Text(
            'No songs in the playlist',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        );
      } else {
        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: myPlaylistsVM.allList.length,
          itemBuilder: (context, index) {
            var song = myPlaylistsVM.allList[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  song.image,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                song.title,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '${song.artist} • ${song.album}',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                Get.to(() => MainPlayerView(song: song));
              },
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  myPlaylistsVM.removeFromPlaylist(song);
                },
              ),
            );
          },
        );
      }
    });
  }
}
