import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key, required this.txt, required this.content});
  final String txt;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenSize.hight * 0.05),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorLight,
          ],
        ),
      ),
      width: ScreenSize.width,
      height: ScreenSize.hight * 0.07,
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: ScreenSize.width * 0.03),
          Text(
            "$txt : ",
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: ScreenSize.hight * 0.022,
            ),
          ),
          SizedBox(width: ScreenSize.width * 0.03),
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            content,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: ScreenSize.hight * 0.018,
            ),
          ),
        ],
      ),
    );
  }
}
