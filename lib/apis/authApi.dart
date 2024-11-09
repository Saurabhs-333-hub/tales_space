import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../appwrite_config/appwrite_config.dart';
import '../constants/constants.dart';
import '../utils/failure.dart';
import '../utils/type_def.dart';

final authApiProvider = Provider((ref) {
  return AuthApi(
      account: ref.watch(firebaseInstanceProvider),
      databases: ref.watch(firestoreProvider));
});

abstract class AuthApiInterface {
  FutureEither<User?> signUp(
      {required String email, required String password, required String name});
  // FutureEither<Document> updateUser({required UserModel userModel});
  FutureEither<User?> signIn({required String email, required String password});
  FutureEither<User?> signInWithGoogle({required BuildContext context});
  Future<User?> currentUserAccount();

  FutureVoid signOut();
}

class AuthApi implements AuthApiInterface {
  final FirebaseAuth _account;
  final FirebaseFirestore _databases;
  AuthApi({required FirebaseAuth account, required FirebaseFirestore databases})
      : _account = account,
        _databases = databases;
  @override
  Future<User?> currentUserAccount() async {
    try {
      return _account.currentUser;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<User?> signIn(
      {required String email, required String password}) async {
    try {
      final account = await _account.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = _account.currentUser;
      await user?.sendEmailVerification();
      return right(user);
    } on FirebaseAuthException catch (e, st) {
      return left(Failure(e.message ?? "Something went wrong!", st.toString()));
    } catch (e, st) {
      return left(Failure(e.toString(), st.toString()));
    }
  }

  @override
  FutureEither<User?> signInWithGoogle({required BuildContext context}) async {
    try {
      await _account.signInWithProvider(GoogleAuthProvider());
      User? user = _account.currentUser;

      return right(user);
    } catch (e, st) {
      Constants.logger.e("SIGN IN WITH GOOGLE ERROR>>>>>>>>>>>>>>>>>>>>>>>$e");
      return left(Failure(e.toString(), st.toString()));
    }
  }

  @override
  FutureEither<User?> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final account = await _account.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(account.user);
    } on FirebaseAuthException catch (e, st) {
      return left(Failure(e.message ?? "Something went wrong!", st.toString()));
    } catch (e, st) {
      return left(Failure(e.toString(), st.toString()));
    }
  }

  // @override
  // FutureEither<Document> updateUser({required UserModel userModel}) async {
  //   try {
  //     final document = await _databases.updateDocument(
  //         databaseId: databaseId,
  //         collectionId: collectionIdUsers,
  //         data: userModel.toMap(),
  //         documentId: userModel.userid);
  //     return right(document);
  //   } on AppwriteException catch (e, st) {
  //     return left(Failure(e.message ?? "Something went wrong!", st.toString()));
  //   } catch (e, st) {
  //     return left(Failure(e.toString(), st.toString()));
  //   }
  // }

  @override
  FutureVoid signOut() {
    return _account.signOut();
  }
}
