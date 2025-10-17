import 'package:bloc/bloc.dart';
import 'package:chats/features/authentication/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      emit(RegisterLoading());
      UserModel userModel = UserModel(
        email: email,
        name: name,
        password: password,
        phone: phone,
      );
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      await users.doc(email).set(userModel.toJson());
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterError(message: e.code));
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }

  checkVerification() async {
    emit(VerificationLoading());
    await FirebaseAuth.instance.currentUser!.reload();
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      emit(VerificationSuccess());
    } else {
      emit(VerificationError(message: "Verify Your Email"));
    }
  }

  login({required String email, required String password}) async {
    try {
      emit(SignInLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignInError(message: e.code));
    } on Exception catch (e) {
      emit(SignInError(message: e.toString()));
    }
  }
}
