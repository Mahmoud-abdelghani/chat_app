import 'dart:io';
import 'dart:math';

import 'package:chats/features/authentication/data/models/user_model.dart';
import 'package:chats/features/chat/data/models/message_model.dart';
import 'package:chats/features/chat/presentation/cubit/messages_cubit.dart';
import 'package:chats/features/chat/presentation/pages/chat_view.dart';
import 'package:chats/features/home/presentation/cubit/chats_cubit.dart';
import 'package:chats/features/home/presentation/widgets/leading_view.dart';
import 'package:chats/features/home/presentation/widgets/person_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  List<UserModel> users = [];
  List<MessageModel> recentMessages = [];
  List<MessageModel> listOfMessages = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        if (state is ChatsLoading) {
          return Column(
            children: [
              LeadingView(users: []),
              // Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          );
        } else if (state is ChatsSuccess) {
          users = state.listOfUsers;
          return Column(
            children: [
              LeadingView(users: users),
              StreamBuilder<QuerySnapshot>(
                stream: BlocProvider.of<MessagesCubit>(
                  context,
                ).getAllMymessages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(child: SizedBox());
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: Text("error to streaming the messages"),
                    );
                  } else if (snapshot.hasData) {
                    var messages = snapshot.data!.docs;
                    listOfMessages = messages
                        .map(
                          (e) => MessageModel.fromJson(
                            e.data() as Map<String, dynamic>,
                          ),
                        )
                        .toList();
                    listOfMessages.sort((a, b) {
                      return b.dateTime.compareTo(a.dateTime);
                    });
                    recentMessages = [];

                    if (listOfMessages.isNotEmpty) {
                      for (var element in List.from(listOfMessages)) {
                        MessageModel messageModel = listOfMessages.first;
                        recentMessages.add(listOfMessages.first);
                        FirebaseAuth.instance.currentUser!.email ==
                                messageModel.senderEmail
                            ? listOfMessages.removeWhere(
                                (element) =>
                                    element.recieverEmail ==
                                        messageModel.recieverEmail ||
                                    element.senderEmail ==
                                        messageModel.recieverEmail,
                              )
                            : listOfMessages.removeWhere(
                                (element) =>
                                    element.recieverEmail ==
                                        messageModel.senderEmail ||
                                    element.senderEmail ==
                                        messageModel.senderEmail,
                              );
                        if (listOfMessages.isEmpty) {
                          break;
                        }
                      }
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: recentMessages.length,
                        itemBuilder: (context, index) {
                          return PersonWidget(
                            name:
                                recentMessages[index].senderEmail ==
                                    FirebaseAuth.instance.currentUser!.email
                                ? state
                                      .listOfUsers[state.listOfUsers.indexWhere(
                                        (element) =>
                                            element.email ==
                                            recentMessages[index].recieverEmail,
                                      )]
                                      .name
                                : state
                                      .listOfUsers[state.listOfUsers.indexWhere(
                                        (element) =>
                                            element.email ==
                                            recentMessages[index].senderEmail,
                                      )]
                                      .name,
                            message: recentMessages[index].message,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ChatView.routeName,
                                arguments:
                                    state.listOfUsers[state.listOfUsers
                                        .indexWhere(
                                          (element) =>
                                              FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .email ==
                                                  recentMessages[index]
                                                      .senderEmail
                                              ? element.email ==
                                                    recentMessages[index]
                                                        .recieverEmail
                                              : element.email ==
                                                    recentMessages[index]
                                                        .senderEmail,
                                        )],
                              );
                            },
                            url:
                                FirebaseAuth.instance.currentUser!.email ==
                                    recentMessages[index].senderEmail
                                ? state
                                      .listOfUsers[state.listOfUsers.indexWhere(
                                        (element) =>
                                            element.email ==
                                            recentMessages[index].recieverEmail,
                                      )]
                                      .image
                                : state
                                      .listOfUsers[state.listOfUsers.indexWhere(
                                        (element) =>
                                            element.email ==
                                            recentMessages[index].senderEmail,
                                      )]
                                      .image,
                          );
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Text("error to streaming the messages"),
                    );
                  }
                },
              ),
            ],
          );
        } else if (state is ChatsError) {
          return Text(state.message);
        } else {
          return Text("can not loading chats");
        }
      },
    );
  }
}
