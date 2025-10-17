import 'package:cached_network_image/cached_network_image.dart';
import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdateView extends StatefulWidget {
  const UpdateView({super.key});
  static const String routeName = "updateView";

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  bool updated = false;
  @override
  Widget build(BuildContext context) {
    String? image = ModalRoute.of(context)!.settings.arguments as String?;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateSuccess) {
          Navigator.pop(context);
          BlocProvider.of<ProfileCubit>(context).getUserInfo();
        } else if (state is UpdateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UpdateLoading,
          child: Scaffold(
            floatingActionButton: updated
                ? FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<ProfileCubit>(
                        context,
                      ).uploadImageToFirebase();
                    },

                    child: Icon(Icons.edit),
                  )
                : null,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await BlocProvider.of<ProfileCubit>(context).pickImage();
                    updated = true;
                    setState(() {});
                  },

                  child: CircleAvatar(
                    radius: ScreenSize.width * 0.5,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        context.watch<ProfileCubit>().profileImage != null
                        ? FileImage(context.read<ProfileCubit>().profileImage!)
                        : image == null
                        ? AssetImage("assets/download.jpg")
                        : CachedNetworkImageProvider(image),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
