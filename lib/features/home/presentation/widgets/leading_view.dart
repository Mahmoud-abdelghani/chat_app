import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:chats/features/authentication/data/models/user_model.dart';
import 'package:chats/features/chat/presentation/pages/chat_view.dart';
import 'package:chats/features/home/presentation/widgets/custom_text_button.dart';
import 'package:chats/features/home/presentation/widgets/person_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeadingView extends StatelessWidget {
  const LeadingView({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    List<String> names = users.map((e) => e.name).toList();
    return Container(
      alignment: Alignment.bottomCenter,
      width: ScreenSize.width,
      height: ScreenSize.hight * 0.2112,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ScreenSize.width * 0.07),
          bottomRight: Radius.circular(ScreenSize.width * 0.07),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 20,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(flex: 3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
            child: Autocomplete<UserModel>(
              displayStringForOption: (UserModel user) => user.name,
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return Iterable<UserModel>.empty();
                }
                return users.where(
                  (UserModel user) => user.name.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
                );
              },
              onSelected: (UserModel user) {
                Navigator.pushNamed(
                  context,
                  ChatView.routeName,
                  arguments: user,
                );
              },
              fieldViewBuilder:
                  (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) => SearchBar(
                    controller: textEditingController,
                    focusNode: focusNode,

                    hintText: "Search by name, number...",
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).disabledColor,
                    ),
                    trailing: Iterable.generate(
                      1,
                      (index) => Icon(Icons.search),
                    ),
                  ),
              // optionsViewBuilder: (context, onSelected, options) =>
              //     ListView.builder(
              //       itemCount: users.length,
              //       itemBuilder: (context, index) => PersonWidget(
              //         name: users[index].name,
              //         message: users[index].email,
              //         onTap: () {},
              //       ),
              //     ),
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextButton(txt: "Chats"),
              CustomTextButton(txt: "Calls"),
            ],
          ),
        ],
      ),
    );
  }
}
