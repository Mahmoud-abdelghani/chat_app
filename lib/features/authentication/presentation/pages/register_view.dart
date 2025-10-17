import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chats/features/authentication/presentation/pages/login_view.dart';
import 'package:chats/features/authentication/presentation/pages/verification_view.dart';
import 'package:chats/features/authentication/presentation/widgets/custom_button.dart';
import 'package:chats/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:chats/features/authentication/presentation/widgets/view_header.dart';
import 'package:chats/features/authentication/presentation/widgets/view_tail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static const String routeName = "RegisterView";
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
  TextEditingController phaoneController = TextEditingController();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  bool isSecured = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Verify Your email"),
              backgroundColor: ColorGuide.mainColor,
            ),
          );
          Navigator.pushReplacementNamed(context, VerificationView.routeName);
        } else if (state is RegisterError) {
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
          color: Theme.of(context).primaryColorLight,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColorLight,
            color: Theme.of(context).primaryColor,
          ),
          inAsyncCall: state is RegisterLoading,
          child: Scaffold(
            body: Column(
              children: [
                ViewHeader(
                  subTitle: "Fill up your details to register.",
                  title: "Register",
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width * 0.05,
                    ),
                    children: [
                      SizedBox(height: ScreenSize.hight * 0.046),
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
                      SizedBox(height: ScreenSize.hight * 0.046),
                      CustomFormField(
                        controller: nameController,
                        keysType: TextInputType.text,
                        fieldKey: nameKey,
                        fieldHint: "Enter your name",
                        fieldLabdel: "name",
                        validation: (p0) {
                          if (p0!.isEmpty) {
                            return "fill that field";
                          } else {
                            return null;
                          }
                        },
                        isObsecuried: false,
                        icon: Icons.person,
                        isPassword: false,
                      ),
                      SizedBox(height: ScreenSize.hight * 0.046),
                      CustomFormField(
                        controller: phaoneController,
                        keysType: TextInputType.number,
                        fieldKey: phoneKey,
                        fieldHint: "Enter your phone",
                        fieldLabdel: "phone",
                        validation: (p0) {
                          if (p0!.isEmpty) {
                            return "fill that field";
                          } else {
                            return null;
                          }
                        },
                        isObsecuried: false,
                        icon: Icons.call,
                        isPassword: false,
                      ),
                      SizedBox(height: ScreenSize.hight * 0.046),
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
                          if (emailKey.currentState!.validate()) {
                            if (passwordKey.currentState!.validate()) {
                              if (phoneKey.currentState!.validate()) {
                                if (nameKey.currentState!.validate()) {
                                  context.read<AuthenticationCubit>().register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phaoneController.text,
                                  );
                                }
                              }
                            }
                          }
                        },
                        txt: "Register",
                      ),
                      SizedBox(height: ScreenSize.hight * 0.0359),
                      ViewTail(
                        normalText: "Already have an account",
                        textButton: "Login",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: ScreenSize.hight * 0.0359),
                    ],
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
