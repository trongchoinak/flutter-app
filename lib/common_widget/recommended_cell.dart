import 'package:flutter/material.dart';
import 'package:music_player/models/song_model.dart'; // Đảm bảo đường dẫn đúng với Song model

class RecommendedCell extends StatelessWidget {
  final Song mObj;

  const RecommendedCell({Key? key, required this.mObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              mObj.image,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            mObj.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            mObj.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
