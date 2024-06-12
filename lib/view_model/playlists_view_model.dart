import 'package:get/get.dart';

class PlaylistsViewModel extends GetxController {
    final playlistArr = [
        {
            "image":"assets/img/dj.png",
            "name":"My Top Track",
            "songs":"100 Songs"
        },
        {
            "image": "assets/img/dj2.jpg",
            "name": "Latest Added",
            "songs": "323 Songs"
        },
        {
            "image": "assets/img/dj3.jpg",
            "name": "History",
            "songs": "450 Songs"
        },
        {
            "image": "assets/img/dj4.jpg",
            "name": "Favorites",
            "songs": "966 Songs"
        }
    ].obs;

    final myPlaylistArr = [
        {
            "image": "assets/img/dj5.jpg",
            "name": "Queens Collection"
        },
        {
            "image": "assets/img/dj6.jpg",
            "name": "Rihanna Collection"
        },
        {
            "image": "assets/img/dj7.jpg",
            "name": "MJ Collection"
        },
        {
            "image": "assets/img/dj8.jpg",
            "name": "Classical Collection"
        }
    ].obs;

}
