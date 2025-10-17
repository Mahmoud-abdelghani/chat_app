import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chats/features/authentication/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  UserModel userModel = UserModel(email: "", name: "", password: "", phone: "");
  getUserInfo() async {
    try {
      emit(ProfileLoading());
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();

      userModel = UserModel.fromJson(user.data()!);
      print(userModel.email);
      emit(ProfileSuccess(userModel: UserModel.fromJson(user.data()!)));
    } on FirebaseException catch (e) {
      emit(ProfileError(message: e.code));
    }
  }

  File? profileImage;
  String? path;
  String? url;
  SupabaseClient supabaseClient = Supabase.instance.client;
  pickImage() async {
    XFile? selectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (selectedImage != null) {
      profileImage = File(selectedImage.path);
    }
  }

  uploadImageToSupabase() async {
    try {
      DateTime dateTime = DateTime.now();
      path = basename(profileImage!.path);
      await supabaseClient.storage
          .from('chat_app')
          .upload("${dateTime}_$path", profileImage!);
      url = supabaseClient.storage
          .from('chat_app')
          .getPublicUrl("${dateTime}_$path");
      print("#########################################################");
      print(url);
      return url;
    } on Exception catch (e) {
      emit(UpdateError(message: e.toString()));
    }
  }

  uploadImageToFirebase() async {
    try {
      emit(UpdateLoading());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({"image": await uploadImageToSupabase()});
      emit(UpdateSuccess());
    } on FirebaseException catch (e) {
      emit(UpdateError(message: e.code));
    }
  }

  updateprofile({required String key, required String updatedValue}) async {
    try {
      emit(UpdateLoading());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({key: updatedValue});
      profileImage = null;
      emit(UpdateSuccess());
    } on FirebaseException catch (e) {
      emit(UpdateError(message: e.code));
    }
  }
}
