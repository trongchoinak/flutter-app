import 'package:flutter/material.dart';
import 'package:music_player/models/song_model.dart'; // Đảm bảo đường dẫn đúng với Song model
import '../common/color_extension.dart';

class AllSongRow extends StatelessWidget {
  final Song song;
  final VoidCallback onPressedPlay;
  final VoidCallback onPressed;

  const AllSongRow({
    Key? key,
    required this.song,
    required this.onPressed,
    required this.onPressedPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    song.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error); // Hiển thị biểu tượng lỗi nếu không tải được hình ảnh
                    },
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: TColor.primaryText28),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: TColor.bg,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    style: TextStyle(
                      color: TColor.primaryText60,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    song.artist,
                    maxLines: 1,
                    style: TextStyle(
                      color: TColor.primaryText28,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'Album: ${song.album}',
                    maxLines: 1,
                    style: TextStyle(
                      color: TColor.primaryText28,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'Duration: ${song.duration} seconds',
                    maxLines: 1,
                    style: TextStyle(
                      color: TColor.primaryText28,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onPressedPlay,
              icon: Image.asset(
                "assets/img/play_btn.png",
                width: 25,
                height: 25,
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.white.withOpacity(0.07),
          indent: 50,
        ),
      ],
    );
  }
}
