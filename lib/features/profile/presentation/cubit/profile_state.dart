part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final UserModel userModel;
  ProfileSuccess({required this.userModel});
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}

final class UpdateLoading extends ProfileState {}

final class UpdateSuccess extends ProfileState {}

final class UpdateError extends ProfileState {
  final String message;
  UpdateError({required this.message});
}
