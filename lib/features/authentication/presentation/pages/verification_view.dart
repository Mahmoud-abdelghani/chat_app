import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chats/features/authentication/presentation/pages/login_view.dart';
import 'package:chats/features/authentication/presentation/widgets/custom_button.dart';
import 'package:chats/features/authentication/presentation/widgets/view_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});
  static const String routeName = "VerificationView";
  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is VerificationSuccess) {
          Navigator.of(context).pushReplacementNamed(LoginView.routeName);
        } else if (state is VerificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: ColorGuide.mainColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is VerificationLoading,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColorLight,
            color: Theme.of(context).primaryColor,
          ),
          child: Scaffold(
            body: Column(
              children: [
                ViewHeader(
                  subTitle: "Verify your email",
                  title: "Verification",
                ),
                Spacer(),
                Text(
                  textAlign: TextAlign.center,
                  "We have sent you a verification Link to your email",
                  style: TextStyle(fontSize: ScreenSize.hight * 0.03),
                ),
                Spacer(),
                CustomButton(
                  onTap: () async {
                    context.read<AuthenticationCubit>().checkVerification();
                  },
                  txt: "Verified",
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
