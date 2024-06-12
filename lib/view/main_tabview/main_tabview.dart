import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/color_extension.dart';
import 'package:music_player/common_widget/icon_text_row.dart';
import 'package:music_player/view/settings/settings_view.dart';
import 'package:music_player/view/songs/songs_view.dart';
import 'package:music_player/view_model/splash_view_model.dart';
import '../home/home_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);

    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.dispose();
  }

  void _goToHome() {
    controller?.animateTo(0); // Chuyển đến tab đầu tiên
    Navigator.of(context).pop(); // Đóng drawer
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    var splashVM = Get.find<SplashViewMode>();

    return Scaffold(
      key: splashVM.scaffoldKey,
      drawer: Drawer(
        backgroundColor: const Color(0xff10121D),
        child: SingleChildScrollView(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true, // Thêm dòng này để tránh lỗi overflow
            children: [
              SizedBox(
                height: 240,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: TColor.primaryText.withOpacity(0.03),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Bo tròn góc với bán kính 20
                        child: Image.asset(
                          "assets/img/logo.jpg",
                          width: media.width * 0.25, // Tăng kích thước ảnh
                          height: media.width * 0.25, // Tăng kích thước ảnh để cân đối
                          fit: BoxFit.cover, // Đảm bảo ảnh vừa khít với kích thước đã đặt
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "10\nSongs",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffC1C0C0), fontSize: 12),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "30\nArtists",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffC1C0C0), fontSize: 12),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              IconTextRow(
                title: "Trang chủ",
                icon: "assets/img/homene.jpg",
                onTap:  _goToHome,
              ),
              IconTextRow(
                title: "Cân bằng",
                icon: "assets/img/canbang.png",
                onTap: () {},
              ),
              IconTextRow(
                title: "Chế độ lái xe ",
                icon: "assets/img/chedolaixe.jpg",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          HomeView(),
          SongsView(),
          // Add your third tab view here if needed
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: TColor.bg, boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 5,
            offset: Offset(0, -3),
          )
        ]),
        child: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: TabBar(
              controller: controller,
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: TColor.primary,
              labelStyle: const TextStyle(fontSize: 10),
              unselectedLabelColor: TColor.primaryText28,
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              tabs: [
                Tab(
                  text: "Trang chủ",
                  icon: Image.asset(
                    selectTab == 0
                        ? "assets/img/home_tab.png"
                        : "assets/img/home_tab_un.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                Tab(
                  text: "Songs",
                  icon: Image.asset(
                    selectTab == 1
                        ? "assets/img/songs_tab.png"
                        : "assets/img/songs_tab_un.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                // Add your third tab here if needed
              ],
            )),
      ),
    );
  }
}
