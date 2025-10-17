import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/data/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatLeading extends StatelessWidget {
  ChatLeading({super.key, required this.name, this.url});
  String? url;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenSize.width * 0.05,
        top: ScreenSize.hight * 0.05,
      ),
      width: ScreenSize.width,
      height: ScreenSize.hight * 0.12,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ScreenSize.width * 0.07),
          bottomRight: Radius.circular(ScreenSize.width * 0.07),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 20,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundImage: url != null
                ? NetworkImage(url!)
                : AssetImage("assets/download.jpg"),
          ),
          SizedBox(width: ScreenSize.width * 0.05),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenSize.hight * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
