import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:music_player/models/song_model.dart'; // Điều chỉnh đường dẫn dựa trên cấu trúc của dự án

class AllSongsViewModel extends GetxController {
    var allList = <Song>[].obs;
    var isLoading = true.obs;

    @override
    void onInit() {
        super.onInit();
        fetchSongs();
    }

    Future<void> fetchSongs() async {
        try {
            isLoading(true);
            print('Fetching songs...');
            final response = await http.get(
                Uri.parse('https://thantrieu.com/resources/braniumapis/songs.json'),
            );
            print('Response status: ${response.statusCode}');
            if (response.statusCode == 200) {
                final bodycontent = utf8.decode(response.bodyBytes);
                var songWrapper = jsonDecode(bodycontent) as Map;
                var songList = songWrapper['songs'] as List ;
                List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
                print('Fetched ${songs.length} songs: $songs'); // Thêm dòng này để in ra dữ liệu trả về
                allList.assignAll(songs); // Cập nhật danh sách các bài hát
            } else {
                // Xử lý lỗi khi không thể lấy dữ liệu từ API
                print('Error fetching songs: ${response.statusCode}');
            }
        } catch (e) {
            // Xử lý các ngoại lệ có thể xảy ra trong quá trình gọi API
            print('Error fetching songs: $e');
        } finally {
            isLoading(false);
        }
    }

}
