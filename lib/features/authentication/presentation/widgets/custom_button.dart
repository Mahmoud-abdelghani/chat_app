import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.txt});
  final VoidCallback onTap;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(ScreenSize.width * 0.888, ScreenSize.hight * 0.076),
      ),

      child: Text(
        txt,
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenSize.hight * 0.028,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
