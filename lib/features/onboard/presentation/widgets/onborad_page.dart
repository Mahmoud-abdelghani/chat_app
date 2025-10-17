import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OnboradPage extends StatelessWidget {
  const OnboradPage({super.key, required this.txt});
  final String txt;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.1027),
      child: Column(
        children: [
          Spacer(flex: 1),
          Image.asset(
            "assets/onboard.png",
            width: ScreenSize.width * 0.79166,
            height: ScreenSize.hight * 0.445,
            fit: BoxFit.cover,
          ),
          Text(
            txt,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenSize.hight * 0.034,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(flex: 2),
         
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
