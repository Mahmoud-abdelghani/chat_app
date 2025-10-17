import 'package:chats/core/database/cache_helper.dart';
import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/presentation/pages/login_view.dart';
import 'package:chats/features/authentication/presentation/widgets/custom_button.dart';
import 'package:chats/features/onboard/presentation/widgets/onborad_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});
  static const String routeName = "OnboradView";
  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  PageController onboardController = PageController();
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: ColorGuide.secondColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: onboardController,
            onPageChanged: (value) {
              print(value);
            },

            children: [
              OnboradPage(
                txt: "Welcome to chatboat,a great friend to chat with you",
              ),
              OnboradPage(
                txt:
                    "If you are confused about what to do just open Chatboat app",
              ),
              OnboradPage(txt: "Chatboat will be readyto chat & make youhappy"),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: ScreenSize.hight * 0.05),
            child: CustomButton(
              onTap: () {
                if (onboardController.page != 2.0) {
                  onboardController.animateToPage(
                    onboardController.page!.toInt() + 1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                } else {
                  Navigator.pushReplacementNamed(context, LoginView.routeName);
                  CacheHelper.saveData(key: "onboarded", value: true);
                }
              },
              txt: "Next",
            ),
          ),
          Positioned(
            bottom: ScreenSize.hight * 0.87,
            left: ScreenSize.width * 0.75,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginView.routeName);
                CacheHelper.saveData(key: "onboarded", value: true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorGuide.loadingColor,
              ),
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenSize.hight * 0.02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
