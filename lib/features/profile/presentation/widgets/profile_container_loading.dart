import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileContainerLoading extends StatelessWidget {
  const ProfileContainerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColorLight,
      highlightColor: Theme.of(context).primaryColorDark,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenSize.hight * 0.05),
          color: Theme.of(context).disabledColor,
        ),
        width: ScreenSize.width,
        height: ScreenSize.hight * 0.07,
        margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
      ),
    );
  }
}
