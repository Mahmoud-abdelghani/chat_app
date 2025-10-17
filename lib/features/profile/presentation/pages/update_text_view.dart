import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/presentation/widgets/custom_button.dart';
import 'package:chats/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:chats/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdateTextView extends StatefulWidget {
  const UpdateTextView({super.key});
  static const String routeName = "UpdateTextView";

  @override
  State<UpdateTextView> createState() => _UpdateTextViewState();
}

class _UpdateTextViewState extends State<UpdateTextView> {
  GlobalKey<FormState> editorKey = GlobalKey<FormState>();
  TextEditingController editorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String updatedKey = ModalRoute.of(context)!.settings.arguments as String;
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
            appBar: AppBar(
              title: Text(
                "Edit $updatedKey",
                style: TextStyle(
                  fontSize: ScreenSize.hight * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomFormField(
                  fieldKey: editorKey,
                  fieldHint: "edit your $updatedKey",
                  fieldLabdel: updatedKey,
                  validation: (p0) {
                    return null;
                  },
                  isObsecuried: false,
                  icon: Icons.edit,
                  isPassword: false,
                  keysType: updatedKey == "phone"
                      ? TextInputType.number
                      : updatedKey == "email"
                      ? TextInputType.emailAddress
                      : TextInputType.name,
                  controller: editorController,
                ),
                CustomButton(
                  onTap: () {
                    if (editorController.text.isNotEmpty) {
                      BlocProvider.of<ProfileCubit>(context).updateprofile(
                        key: updatedKey,
                        updatedValue: editorController.text,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Write your new $updatedKey")),
                      );
                    }
                  },
                  txt: "Edit",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
