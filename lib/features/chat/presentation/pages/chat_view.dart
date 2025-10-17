import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/data/models/user_model.dart';
import 'package:chats/features/chat/data/models/message_model.dart';
import 'package:chats/features/chat/presentation/cubit/messages_cubit.dart';
import 'package:chats/features/chat/presentation/widgets/chat_leading.dart';
import 'package:chats/features/chat/presentation/widgets/reciever_chat.dart';
import 'package:chats/features/chat/presentation/widgets/sender_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  static const String routeName = "chatView";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel reciever =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          if (messageController.text.isNotEmpty) {
            BlocProvider.of<MessagesCubit>(context).sendMessage(
              recieverEmail: reciever.email,
              message: messageController.text,
              dateTime: Timestamp.now(),
            );
            messageController.clear();
            setState(() {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 100),
                curve: Curves.linear,
              );
            });
          }
        },

        child: messageController.text.isEmpty
            ? Icon(Icons.mic, size: ScreenSize.hight * 0.04)
            : Icon(Icons.send, size: ScreenSize.hight * 0.04),
      ),

      body: Column(
        children: [
          ChatLeading(name: reciever.name, url: reciever.image),

          StreamBuilder<QuerySnapshot>(
            stream: BlocProvider.of<MessagesCubit>(
              context,
            ).getMessagesOfSpecificPerson(reciever.email),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var messages = snapshot.data!.docs;
                List<MessageModel> list = messages
                    .map(
                      (e) => MessageModel.fromJson(
                        e.data() as Map<String, dynamic>,
                      ),
                    )
                    .toList();
                list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
                listIndex = list.length - 1;
                return Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return list[index].senderEmail ==
                              FirebaseAuth.instance.currentUser!.email
                          ? SenderChat(
                              txt: list[index].message,
                              timestamp: list[index].dateTime,
                            )
                          : RecieverChat(
                              txt: list[index].message,
                              timestamp: list[index].dateTime,
                            );
                    },
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(child: SizedBox());
              } else if (snapshot.hasError) {
                return Expanded(child: Text("error to streaming the messages"));
              } else {
                return Expanded(child: Text("error to streaming the messages"));
              }
            },
          ),
          Container(
            padding: EdgeInsets.only(
              left: ScreenSize.width * 0.025,
              right: ScreenSize.width * 0.18,
              top: ScreenSize.hight * 0.035,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenSize.hight * 0.05),
                topRight: Radius.circular(ScreenSize.hight * 0.05),
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 20,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            height: ScreenSize.hight * 0.14,
            width: ScreenSize.width,
            child: TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: messageController,
              style: TextStyle(color: Theme.of(context).hintColor),
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenSize.hight * 0.05),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenSize.hight * 0.05),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                hint: Text(
                  'Type your message here.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
