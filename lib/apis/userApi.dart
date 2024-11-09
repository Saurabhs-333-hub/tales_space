import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../appwrite_config/appwrite_config.dart';
import '../models/user_model.dart';
import '../utils/failure.dart';
import '../utils/type_def.dart';

final userApiProvider = Provider((ref) {
  return UserApi(db: ref.watch(firestoreProvider));
});

abstract class UserApiInterface {
  FutureEitherVoid saveUserData(UserModel usermodel);
  Future<UserModel> getUserData(String uid);
  Future<List<UserModel>> getAllUsers();
  Future<List<UserModel>> searchUserByName(String username);
  // FutureEitherVoid saveUserSettingsData(UserSettingsModel userSettingsModel);
}

class UserApi implements UserApiInterface {
  final FirebaseFirestore _db;
  UserApi({required FirebaseFirestore db})
      : _db = db,
        super();
  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db
          .collection('users')
          .doc(userModel.userid)
          .set(userModel.toMap(), SetOptions(merge: true));
      return right(null);
    } on FirebaseException catch (e, st) {
      return left(Failure(e.message ?? 'Something went wrong!', st.toString()));
    } catch (e, st) {
      return left(Failure(e.toString(), st.toString()));
    }
  }

  @override
  Future<UserModel> getUserData(String uid) async {
    final res = await _db.collection('users').doc(uid).get();
    return UserModel.fromMap(res.data()!);
    ;
  }

  @override
  Future<List<UserModel>> searchUserByName(String username) async {
    final documents = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    if (documents.docs.isNotEmpty) {
      return documents.docs.map((e) => UserModel.fromMap(e.data())).toList();
    }
    return [];
  }

  // @override
  // FutureEitherVoid saveUserSettingsData(
  //     UserSettingsModel userSettingsModel) async {
  //   try {
  //     await _db.createDocument(
  //         databaseId: databaseId,
  //         collectionId: collectionIdUserSettings,
  //         documentId: userSettingsModel.userId,
  //         data: userSettingsModel.toMap());
  //     return right(null);
  //   } on AppwriteException catch (e, st) {
  //     return left(Failure(e.message ?? 'Something went wrong!', st.toString()));
  //   } catch (e, st) {
  //     return left(Failure(e.toString(), st.toString()));
  //   }
  // }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final res = await _db.collection('users').get();
    return res.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }
}
