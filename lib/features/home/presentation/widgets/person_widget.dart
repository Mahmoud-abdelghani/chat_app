import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  PersonWidget({
    super.key,
    required this.name,
    required this.message,
    this.url,
    required this.onTap,
  });
  final String name;
  final String message;
  String? url;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      dense: false,
      leading: CircleAvatar(
        radius: ScreenSize.hight * 0.046,

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundImage: url != null
            ? NetworkImage(url!)
            : AssetImage("assets/download.jpg"),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenSize.hight * 0.025,
        ),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.hight * 0.0187,
          color: Colors.grey,
        ),
      ),
    );
  }
}
