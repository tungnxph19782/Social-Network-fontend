import 'package:flutter/material.dart';

class Custompost extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final String content;
  final String imageUrl;
  final int likeCount;
  final int commentCount;
  final String postTime;
  final VoidCallback onLike;
  final VoidCallback onComment;


  Custompost({
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.imageUrl,
    required this.likeCount,
    required this.commentCount,
    required this.postTime,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userAvatar),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Text(
                  userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  postTime,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(content),
            SizedBox(height: 10),
            imageUrl.isNotEmpty
                ? Image.network(imageUrl)
                : SizedBox.shrink(),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: onLike,
                ),
                Text('$likeCount'),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: onComment,
                ),
                Text('$commentCount'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
