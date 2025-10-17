import 'package:chats/features/authentication/data/models/user_model.dart';
import 'package:chats/features/chat/presentation/pages/chat_view.dart';
import 'package:chats/features/home/presentation/cubit/chats_cubit.dart';
import 'package:chats/features/home/presentation/widgets/leading_view.dart';
import 'package:chats/features/home/presentation/widgets/person_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChatsView extends StatefulWidget {
  const AllChatsView({super.key});

  @override
  State<AllChatsView> createState() => _CallsViewState();
}

class _CallsViewState extends State<AllChatsView> {
  List<UserModel> users = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        return Column(
          children: [
            state is ChatsSuccess
                ? LeadingView(users: state.listOfUsers)
                : LeadingView(users: []),
            BlocBuilder<ChatsCubit, ChatsState>(
              builder: (context, state) {
                if (state is ChatsLoading) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ChatsSuccess) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.listOfUsers.length,
                      itemBuilder: (context, index) {
                        return PersonWidget(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ChatView.routeName,
                              arguments: state.listOfUsers[index],
                            );
                          },
                          url: state.listOfUsers[index].image,
                          message: state.listOfUsers[index].email,
                          name: state.listOfUsers[index].name,
                        );
                      },
                    ),
                  );
                } else if (state is ChatsError) {
                  return Text(state.message);
                } else {
                  return Text("error");
                }
              },
            ),
          ],
        );
      },
    );
  }
}
