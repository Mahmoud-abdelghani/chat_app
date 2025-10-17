import 'package:chats/core/utils/color_guide.dart';
import 'package:chats/core/utils/screen_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecieverChat extends StatelessWidget {
  const RecieverChat({super.key, required this.txt, required this.timestamp});
  final String txt;
  final Timestamp timestamp;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: ScreenSize.hight * 0.004,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(ScreenSize.hight * 0.03),
              bottomRight: Radius.circular(ScreenSize.hight * 0.03),
              topRight: Radius.circular(ScreenSize.hight * 0.03),
            ),
          ),
          width: ScreenSize.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: ScreenSize.hight * 0.025,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('HH::mm').format(timestamp.toDate()),
                    style: TextStyle(
                      fontSize: ScreenSize.hight * 0.016,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
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
