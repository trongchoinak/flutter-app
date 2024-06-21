import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common_widget/myplaylists_odaynha.dart';
import 'package:music_player/view_model/myplaylists_view_model.dart';

class MyplaylistsView extends StatefulWidget {
  const MyplaylistsView({super.key});

  @override
  State<MyplaylistsView> createState() => _MyplaylistsViewState();
}

class _MyplaylistsViewState extends State<MyplaylistsView> {
  final MyplaylistsViewModel myPlaylistsVM = Get.put(MyplaylistsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, // Thiết lập màu tím cho AppBar
        automaticallyImplyLeading: false, // Ẩn thanh icon Back
        title: const Text('My Playlists'),
      ),
      body: MyPlaylistsOdayne(),
    );
  }
}
