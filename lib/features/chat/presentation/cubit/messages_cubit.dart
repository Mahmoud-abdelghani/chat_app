import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chats/features/chat/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());

  sendMessage({
    required String recieverEmail,
    required String message,
    required Timestamp dateTime,
  }) async {
    try {
      emit(MessageLoading());
      MessageModel messageModel = MessageModel(
        message: message,
        recieverEmail: recieverEmail,
        senderEmail: FirebaseAuth.instance.currentUser!.email!,
        dateTime: dateTime,
      );
      await FirebaseFirestore.instance
          .collection('messages')
          .add(messageModel.toJson());
      emit(MessagesSuccess());
    } on FirebaseException catch (e) {
      emit(MessagesError());
    }
  }

  Stream<QuerySnapshot<Object?>>? getMessagesOfSpecificPerson(
    String recieverEmail,
  ) async* {
    try {
      yield* FirebaseFirestore.instance
          .collection('messages')
          .where(
            Filter.or(
              Filter.and(
                Filter(
                  'senderEmail',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email,
                ),
                Filter("recieverEmail", isEqualTo: recieverEmail),
              ),
              Filter.and(
                Filter("senderEmail", isEqualTo: recieverEmail),
                Filter(
                  "recieverEmail",
                  isEqualTo: FirebaseAuth.instance.currentUser!.email,
                ),
              ),
            ),
          )
          .snapshots();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot<Object?>>? getAllMymessages() async* {
    try {
      yield* FirebaseFirestore.instance
          .collection('messages')
          .where(
            Filter.or(
              Filter(
                "senderEmail",
                isEqualTo: FirebaseAuth.instance.currentUser!.email,
              ),
              Filter(
                "recieverEmail",
                isEqualTo: FirebaseAuth.instance.currentUser!.email,
              ),
            ),
          )
          .snapshots();
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
