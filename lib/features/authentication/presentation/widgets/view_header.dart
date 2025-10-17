import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class ViewHeader extends StatelessWidget {
  const ViewHeader({super.key, required this.subTitle, required this.title});
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: ScreenSize.width * 0.05),
      width: ScreenSize.width,
      height: ScreenSize.hight * 0.31,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenSize.hight * 0.0469,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: ScreenSize.hight * 0.025,
            ),
          ),
        ],
      ),
    );
  }
}
