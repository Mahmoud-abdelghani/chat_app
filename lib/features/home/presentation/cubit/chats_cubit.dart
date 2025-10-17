import 'package:bloc/bloc.dart';
import 'package:chats/features/authentication/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  getAllUsers() async {
    try {
      emit(ChatsLoading());
      final usersDocs = await FirebaseFirestore.instance
          .collection('users')
          .get();
      List<UserModel> users = usersDocs.docs
          .where(
            (element) =>
                element['email'] != FirebaseAuth.instance.currentUser!.email,
          )
          .map((e) => UserModel.fromJson(e.data()))
          .toList();
      emit(ChatsSuccess(listOfUsers: users));
    } on FirebaseException catch (e) {
      emit(ChatsError(message: e.code));
    }
  }
}
