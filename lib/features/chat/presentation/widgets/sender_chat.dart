import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderChat extends StatelessWidget {
  const SenderChat({super.key, required this.txt, required this.timestamp});
  final String txt;
  final Timestamp timestamp;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(ScreenSize.hight * 0.03),
              bottomRight: Radius.circular(ScreenSize.hight * 0.03),
              topLeft: Radius.circular(ScreenSize.hight * 0.03),
            ),
          ),
          width: ScreenSize.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt,
                style: TextStyle(
                  fontSize: ScreenSize.hight * 0.025,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('HH::mm').format(timestamp.toDate()),
                    style: TextStyle(
                      fontSize: ScreenSize.hight * 0.015,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 227, 227, 227),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
