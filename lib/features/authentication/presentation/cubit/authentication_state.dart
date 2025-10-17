part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class RegisterLoading extends AuthenticationState {}

final class RegisterSuccess extends AuthenticationState {}

final class RegisterError extends AuthenticationState {
  final String message;
  RegisterError({required this.message});
}

final class VerificationLoading extends AuthenticationState {}

final class VerificationSuccess extends AuthenticationState {}

final class VerificationError extends AuthenticationState {
  final String message;
  VerificationError({required this.message});
}

final class SignInLoading extends AuthenticationState {}

final class SignInSuccess extends AuthenticationState {}

final class SignInError extends AuthenticationState {
  final String message;
  SignInError({required this.message});
}