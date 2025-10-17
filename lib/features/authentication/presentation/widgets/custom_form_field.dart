import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    super.key,
    required this.fieldKey,
    required this.fieldHint,
    required this.fieldLabdel,
    required this.validation,
    required this.isObsecuried,
    required this.icon,
    this.visibilityIcon,
    this.onTap,
    required this.isPassword,
    required this.keysType,
    required this.controller,
  });
  final GlobalKey<FormState> fieldKey;
  final String fieldHint;
  final String fieldLabdel;
  final String? Function(String?)? validation;
  final bool isObsecuried;
  final IconData icon;
  Icon? visibilityIcon;
  final bool isPassword;
  VoidCallback? onTap;
  final TextInputType keysType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: fieldKey,
      child: TextFormField(
        style: TextStyle(color: Theme.of(context).hintColor),
        cursorColor: Theme.of(context).primaryColor,
        controller: controller,
        validator: validation,
        obscureText: isObsecuried,
        keyboardType: keysType,
        decoration: InputDecoration(
          hint: Text(fieldHint, style: TextStyle(color: Colors.grey)),
          label: Text(
            fieldLabdel,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ),
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          suffixIcon: isPassword
              ? IconButton(onPressed: onTap, icon: visibilityIcon!)
              : null,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.hight * 0.1),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.hight * 0.1),
            borderSide: BorderSide(color: Colors.grey, width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.hight * 0.1),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.hight * 0.1),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
