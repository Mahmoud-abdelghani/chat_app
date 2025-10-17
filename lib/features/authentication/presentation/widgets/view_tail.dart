import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class ViewTail extends StatelessWidget {
  const ViewTail({
    super.key,
    required this.normalText,
    required this.textButton,
    required this.onTap,
  });
  final String normalText;
  final String textButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          normalText,
          style: TextStyle(
            fontSize: ScreenSize.hight * 0.0187,
            color: Theme.of(context).hintColor,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            textButton,

            style: TextStyle(
              fontSize: ScreenSize.hight * 0.02,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
