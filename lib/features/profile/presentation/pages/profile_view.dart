import 'package:cached_network_image/cached_network_image.dart';
import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/data/models/user_model.dart';
import 'package:chats/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chats/features/profile/presentation/pages/update_text_view.dart';
import 'package:chats/features/profile/presentation/pages/update_view.dart';
import 'package:chats/features/profile/presentation/widgets/profile_container.dart';
import 'package:chats/features/profile/presentation/widgets/profile_container_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static const String routeName = "ProfileView";

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Profile",
                style: TextStyle(
                  fontSize: ScreenSize.hight * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Theme.of(context).primaryColorLight,
                  highlightColor: Theme.of(context).primaryColorDark,
                  child: CircleAvatar(
                    radius: ScreenSize.hight * 0.11,
                    backgroundColor: Theme.of(context).disabledColor,
                  ),
                ),
                ProfileContainerLoading(),
                ProfileContainerLoading(),
                ProfileContainerLoading(),
              ],
            ),
          );
        } else if (state is ProfileSuccess) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Profile",
                style: TextStyle(
                  fontSize: ScreenSize.hight * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UpdateView.routeName,
                      arguments: state.userModel.image,
                    );
                  },
                  child: CircleAvatar(
                    radius: ScreenSize.hight * 0.11,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundImage: state.userModel.image != null
                        ? CachedNetworkImageProvider(state.userModel.image!)
                        : AssetImage("assets/download.jpg"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UpdateTextView.routeName,
                      arguments: "name",
                    );
                  },
                  child: ProfileContainer(
                    txt: "Name",
                    content: state.userModel.name,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UpdateTextView.routeName,
                      arguments: "phone",
                    );
                  },
                  child: ProfileContainer(
                    txt: "Phone",
                    content: state.userModel.phone,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UpdateTextView.routeName,
                      arguments: "email",
                    );
                  },
                  child: ProfileContainer(
                    txt: "email",
                    content: state.userModel.email,
                  ),
                ),
              ],
            ),
          );
        } else if (state is ProfileError) {
          return Scaffold(body: Text(state.message));
        } else {
          return Scaffold(body: Text("Error"));
        }
      },
    );
  }
}
