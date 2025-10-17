import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chats/features/authentication/presentation/pages/register_view.dart';
import 'package:chats/features/authentication/presentation/widgets/custom_button.dart';
import 'package:chats/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:chats/features/authentication/presentation/widgets/view_header.dart';
import 'package:chats/features/authentication/presentation/widgets/view_tail.dart';
import 'package:chats/features/home/presentation/cubit/chats_cubit.dart';
import 'package:chats/features/home/presentation/pages/home_view.dart';
import 'package:chats/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String routeName = "LoginView";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  bool isSecured = true;
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
          BlocProvider.of<ProfileCubit>(context).getUserInfo();
          BlocProvider.of<ChatsCubit>(context).getAllUsers();
        } else if (state is SignInError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignInLoading,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColorLight,
            color: Theme.of(context).primaryColor,
          ),
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ViewHeader(
                  subTitle: "Enter your email and password to continue.",
                  title: "Login",
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width * 0.03,
                    ),
                    child: ListView(
                      children: [
                        SizedBox(height: ScreenSize.hight * 0.056),
                        CustomFormField(
                          controller: emailController,
                          keysType: TextInputType.emailAddress,
                          fieldKey: emailKey,
                          fieldHint: "Enter your email",
                          fieldLabdel: "email",
                          validation: (p0) {
                            if (p0!.isEmpty) {
                              return "fill that field";
                            } else if (!p0.contains('@')) {
                              return "Enter a valid email";
                            } else {
                              return null;
                            }
                          },
                          isObsecuried: false,
                          icon: Icons.email,
                          isPassword: false,
                        ),
                        SizedBox(height: ScreenSize.hight * 0.056),
                        CustomFormField(
                          controller: passwordController,
                          keysType: TextInputType.text,
                          fieldKey: passwordKey,
                          fieldHint: "Enter your password",
                          fieldLabdel: "password",
                          validation: (p0) {
                            if (p0!.isEmpty) {
                              return "fill that field";
                            } else {
                              return null;
                            }
                          },
                          isObsecuried: isSecured,
                          icon: Icons.lock,
                          isPassword: true,
                          onTap: () {
                            isSecured = !isSecured;
                            setState(() {});
                          },
                          visibilityIcon: isSecured
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                        SizedBox(height: ScreenSize.hight * 0.0359),
                        CustomButton(
                          onTap: () {
                            context.read<AuthenticationCubit>().login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                          txt: "Login",
                        ),
                        SizedBox(height: ScreenSize.hight * 0.0359),
                        ViewTail(
                          normalText: "Dont have an account ",
                          textButton: "Register",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RegisterView.routeName,
                            );
                          },
                        ),
                        SizedBox(height: ScreenSize.hight * 0.0359),
                      ],
                    ),
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
