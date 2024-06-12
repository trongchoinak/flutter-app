import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
    final txtSearch = TextEditingController().obs; 

    final hostRecommendedArr = [
        {
            "image": "assets/img/noinaycoanh.png",
            "name": "Nơi này có anh",
            "artists": "Sơn tùng MTP"
        },
        {
            "image": "assets/img/comaogaotien.jpg",
            "name": "Cơm Aó Gạo Tiền",
            "artists": "7dnight"
        },
        {
            "image": "assets/img/comaogaotien.jpg",
            "name": "Cơm Aó Gạo Tiền",
            "artists": "7dnight"
        },
        {
            "image": "assets/img/dlttad.jpg",
            "name": "Đừng làm trái tim anh đau",
            "artists": "Sơn tùng MTP"
        },
        {
            "image": "assets/img/2h.jpg",
            "name": "2H",
            "artists": "MCK"
        }

    ].obs;

    final playListArr = [
        {
            "image": "assets/img/noiaycontimve.png",
            "name": "Nơi ấy con tìm về",
            "artists": "Hồ Quang Hiếu"
        },
        {
            "image": "assets/img/chuyencuboqua.png",
            "name": "Chuyện cũ bỏ qua",
            "artists": "Bích Phương"
        },
        {
            "image": "assets/img/canhhoatan.png",
            "name": "Cánh hoa tàn",
            "artists": "Hương Tràm"
        }
    ];

    final recentlyPlayedArr = [
        {
            "rate": 4,
            "name": "Billie Jean",
            "artists": "Michael Jackson"
        },
        {
            "rate": 4,
            "name": "Earth Song",
            "artists": "Michael Jackson"
        },
        {
            "rate": 4,
            "name": "Mirror",
            "artists": "Justin Timberlake"
        },
        {
            "rate": 4,
            "name": "Remember the Time",
            "artists": "Michael Jackson"
        }
    ].obs;
}

//.navigationViewStyle(StackNavigationViewStyle())
