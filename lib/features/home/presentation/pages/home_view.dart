import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/home/presentation/cubit/chats_cubit.dart';
import 'package:chats/features/home/presentation/widgets/leading_view.dart';
import 'package:chats/features/home/presentation/widgets/list_of_views.dart';
import 'package:chats/features/home/presentation/widgets/person_widget.dart';
import 'package:chats/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String routeName = "HomeView";
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getUserInfo();
    BlocProvider.of<ChatsCubit>(context).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat_sharp), label: "chats"),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_outlined),
            label: "contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "settings",
          ),
        ],
      ),
      body: views[selectedIndex],
    );
  }
}
