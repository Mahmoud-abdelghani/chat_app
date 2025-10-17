part of 'messages_cubit.dart';

@immutable
sealed class MessagesState {}

final class MessagesInitial extends MessagesState {}
final class MessageLoading extends MessagesState {}
final class MessagesSuccess extends MessagesState {}
final class MessagesError extends MessagesState {}