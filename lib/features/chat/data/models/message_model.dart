import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String recieverEmail;
  final String senderEmail;
  final Timestamp dateTime;
  MessageModel({
    required this.message,
    required this.recieverEmail,
    required this.senderEmail,
    required this.dateTime,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      recieverEmail: json['recieverEmail'],
      senderEmail: json['senderEmail'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message':message,
      'recieverEmail':recieverEmail,
      'senderEmail':senderEmail,
      'dateTime':dateTime
    };
  }
}
