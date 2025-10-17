import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.subTitle,
    required this.title,
    required this.iconData,
  });
  final String title;
  final String subTitle;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        size: ScreenSize.hight * 0.04,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenSize.hight * 0.03,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenSize.hight * 0.02,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
