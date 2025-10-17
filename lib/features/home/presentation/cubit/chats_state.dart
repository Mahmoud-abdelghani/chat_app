part of 'chats_cubit.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class ChatsLoading extends ChatsState {}

final class ChatsSuccess extends ChatsState {
  final List<UserModel> listOfUsers;
  ChatsSuccess({required this.listOfUsers});
}

final class ChatsError extends ChatsState {
  final String message;
  ChatsError({required this.message});
}
