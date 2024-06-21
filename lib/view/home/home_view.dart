import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/color_extension.dart';
import 'package:music_player/common_widget/recommended_cell.dart';
import 'package:music_player/common_widget/title_section.dart';
import 'package:music_player/view_model/home_view_model.dart';
import 'package:music_player/common_widget/all_song_row.dart'; // Import AllSongRow
import 'package:music_player/view/main_player/main_player_view.dart'; // Import MainPlayerView

class HomeView extends StatelessWidget {
  final HomeViewModel homeVM = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.org,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Thay thế bằng hàm mở ngăn kéo
          },
          icon: Image.asset(
            "assets/img/menu.png",
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xff292E4B),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: homeVM.txtSearch.value,
                        onSubmitted: (_) => homeVM.performSearch(),
                        style: TextStyle(
                          color: Colors.white, // Màu văn bản là màu trắng
                        ),
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 20,
                          ),
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            width: 30,
                            child: Image.asset(
                              "assets/img/search.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Search album song",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => homeVM.performSearch(),
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (homeVM.txtSearch.value.text.isNotEmpty && homeVM.searchResult.isEmpty) {
          // Hiển thị thông báo khi không có kết quả tìm kiếm
          return Center(
            child: Text(
              'Không có bài nhạc nào mà bạn đang tìm kiếm',
              style: TextStyle(color: TColor.primaryText80, fontSize: 16),
            ),
          );
        } else if (homeVM.searchResult.isEmpty) {
          // Hiển thị các bài hát được đề xuất khi chưa tìm kiếm
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleSection(title: "Hot Recommended"),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: homeVM.hostRecommendedArr.length,
                    itemBuilder: (context, index) {
                      var mObj = homeVM.hostRecommendedArr[index];
                      return RecommendedCell(mObj: mObj);
                    },
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.07),
                  indent: 20,
                  endIndent: 20,
                ),
                // Thay thế bằng các widget của bạn
              ],
            ),
          );
        } else {
          // Hiển thị kết quả tìm kiếm
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleSection(title: "Search Results"),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeVM.searchResult.length,
                  itemBuilder: (context, index) {
                    var song = homeVM.searchResult[index];
                    return AllSongRow(
                      song: song,
                      onPressed: () {
                        // Handle song row tap
                      },
                      onPressedPlay: () {
                        // Điều hướng đến MainPlayerView khi ấn nút play
                        Get.to(() => MainPlayerView(song: song));
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
