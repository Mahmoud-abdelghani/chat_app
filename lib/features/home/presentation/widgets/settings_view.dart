import 'package:cached_network_image/cached_network_image.dart';
import 'package:chats/core/cubit/theme_cubit.dart';
import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/presentation/pages/login_view.dart';
import 'package:chats/features/authentication/presentation/widgets/view_header.dart';
import 'package:chats/features/home/presentation/widgets/settings_item.dart';
import 'package:chats/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chats/features/profile/presentation/pages/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            ViewHeader(
              subTitle: "You can view or edit your profile here",
              title: "Settings",
            ),
            Expanded(
              child: ListView(
                children: [
                  state is ProfileLoading
                      ? ListTile(
                          title: Shimmer.fromColors(
                            baseColor: Theme.of(context).primaryColorLight,
                            highlightColor: Theme.of(context).primaryColorDark,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 7),
                              color: Theme.of(context).disabledColor,
                              width: ScreenSize.width * 0.6,
                              height: ScreenSize.hight * 0.03,
                            ),
                          ),
                          subtitle: Shimmer.fromColors(
                            baseColor: Theme.of(context).primaryColorLight,
                            highlightColor: Theme.of(context).primaryColorDark,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 7),
                              color: Theme.of(context).disabledColor,
                              width: ScreenSize.width * 0.6,
                              height: ScreenSize.hight * 0.02,
                            ),
                          ),
                          shape: Border.symmetric(
                            horizontal: BorderSide(
                              color: Theme.of(context).primaryColorLight,
                              width: 3,
                            ),
                          ),

                          leading: Shimmer.fromColors(
                            baseColor: Theme.of(context).primaryColorLight,
                            highlightColor: Theme.of(context).primaryColorDark,
                            child: CircleAvatar(
                              radius: ScreenSize.hight * 0.035,
                              backgroundColor: Theme.of(
                                context,
                              ).primaryColorLight,
                            ),
                          ),
                        )
                      : state is ProfileSuccess
                      ? ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, ProfileView.routeName);
                            BlocProvider.of<ProfileCubit>(
                              context,
                            ).getUserInfo();
                          },
                          title: Text(
                            state.userModel.name,
                            style: TextStyle(
                              fontSize: ScreenSize.hight * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            state.userModel.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenSize.hight * 0.02,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          shape: Border.symmetric(
                            horizontal: BorderSide(
                              color: Theme.of(context).primaryColorLight,
                              width: 3,
                            ),
                          ),
                          trailing: Icon(
                            Icons.edit,
                            size: ScreenSize.hight * 0.04,
                            color: Theme.of(context).primaryColor,
                          ),
                          dense: false,
                          leading: CircleAvatar(
                            radius: ScreenSize.hight * 0.035,
                            backgroundColor: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                            backgroundImage: state.userModel.image != null
                                ? CachedNetworkImageProvider(
                                    state.userModel.image!,
                                  )
                                : AssetImage("assets/download.jpg"),
                          ),
                        )
                      : ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, ProfileView.routeName);
                          },
                          title: Text(
                            "Mahmoud Abdelghani",
                            style: TextStyle(
                              fontSize: ScreenSize.hight * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "No time to Die",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenSize.hight * 0.02,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          shape: Border.symmetric(
                            horizontal: BorderSide(
                              color: Theme.of(context).primaryColorLight,
                              width: 3,
                            ),
                          ),
                          trailing: Icon(
                            Icons.edit,
                            size: ScreenSize.hight * 0.04,
                            color: Theme.of(context).primaryColor,
                          ),
                          dense: false,
                          leading: CircleAvatar(
                            radius: ScreenSize.hight * 0.035,
                            backgroundColor: ColorGuide.mainColor,
                          ),
                        ),
                  SettingsItem(
                    subTitle: "security notifications, change number",
                    title: "Account",
                    iconData: Icons.key,
                  ),
                  SettingsItem(
                    subTitle: "Block contacts, disappearing messages",
                    title: "Privacy",
                    iconData: Icons.lock_outline,
                  ),
                  SettingsItem(
                    subTitle: "create, edit, profile Photo",
                    title: "Avatar",
                    iconData: Icons.person_4_outlined,
                  ),
                  SettingsItem(
                    subTitle: "Manage peaple and groubs",
                    title: "Lists",
                    iconData: Icons.list_outlined,
                  ),
                  SettingsItem(
                    subTitle: "Theme, wallpapers, chat history",
                    title: "Chats",
                    iconData: Icons.message_outlined,
                  ),
                  SettingsItem(
                    subTitle: "Message, group & call tones",
                    title: "Notification",
                    iconData: Icons.notifications_none_outlined,
                  ),
                  SettingsItem(
                    subTitle: "Network usage, auto-download",
                    title: "Storage and data",
                    iconData: Icons.sd_storage_outlined,
                  ),
                  BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, state) {
                      return ListTile(
                        onTap: () {
                          BlocProvider.of<ThemeCubit>(context).switchMode();
                        },
                        leading: Icon(
                          state == ThemeMode.light
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          size: ScreenSize.hight * 0.04,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          "Switch Mode",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenSize.hight * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Switch between light mode and dark mode",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenSize.hight * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                        context,
                        LoginView.routeName,
                      );
                    },
                    leading: Icon(
                      Icons.logout,
                      size: ScreenSize.hight * 0.04,
                      color: ColorGuide.mainColor,
                    ),
                    title: Text(
                      "Log out",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenSize.hight * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Logout from this account",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenSize.hight * 0.02,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
