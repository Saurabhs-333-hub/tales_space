import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:grock/grock.dart';
import 'package:tales_space/apis/authApi.dart';
import 'package:tales_space/apis/userApi.dart';
import 'package:tales_space/appwrite_config/appwrite_constants.dart';
import 'package:tales_space/constants/constants.dart';
import 'package:tales_space/models/user_model.dart';
import 'package:tales_space/routes.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authAPI = ref.watch(authApiProvider);
  final userAPI = ref.watch(userApiProvider);
  return AuthController(authAPI: authAPI, userApi: userAPI);
});
final currentUserAccountProvider = FutureProvider((ref) async {
  final authController = ref.read(authApiProvider);
  return await authController.currentUserAccount();
});
final currentUserProvider = FutureProvider((ref) async {
  // log('hjh${await ref.watch(currentUserAccountProvider.future)}');

  User currentUser = ref.watch(currentUserAccountProvider).value!;
  // log('${ currentUserId}');
  final userDetails = ref.watch(userDetailsProvider(currentUser.uid)).value;
  return userDetails;
});
final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final allUserProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getAllUsers();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authAPI;
  final UserApi _userApi;
  AuthController({required AuthApi authAPI, required UserApi userApi})
      : _authAPI = authAPI,
        _userApi = userApi,
        super(false);

  Future<User?> currentUser() => _authAPI.currentUserAccount();

  void signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.signIn(email: email, password: password).then(
      (value) {
        state = false;
        value.fold(
          (l) => Grock.snackBar(
            title: 'Error',
            description: l.message,
          ),
          (r) {
            context.go(GoRouterConfig.home);
          },
        );
      },
    );
    state = false;
  }

  void signInWithGoogle({required BuildContext context}) async {
    state = true;
    final res = await _authAPI.signInWithGoogle(context: context);
    res.fold(
      (l) => Constants.logger.e(l.toString()),
      (user) async {
        // Position position = await UtilMethods().getCurrentLatLong();
        UserModel userModel = UserModel(
          bio: 'No Bio',
          email: user!.email!,
          fcmToken: '',
          isSeller: false,
          lat: 'position.latitude',
          long: 'position.longitude',
          profileImage: placeholderDeafultImageUrl,
          userid: user.uid,
          username: '',
        );
        final users = await getAllUsers().then((e) async {
          if (e.any((element) => element.userid == user.uid)) {
            context.goNamed(GoRouterConfig.home);
          } else {
            await _userApi.saveUserData(userModel).then(
              (value) {
                value.fold((l) {
                  Constants.logger.e(l.message);
                }, (r) {
                  context.goNamed(GoRouterConfig.home);
                });
              },
            );
          }
        });
      },
    );
    state = false;
  }

  void signUp(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    state = true;
    final res =
        await _authAPI.signUp(email: email, password: password, name: name);
    state = false;
    res.fold(
        (l) => Grock.snackBar(
              title: 'Error',
              description: l.message,
            ), (r) async {
      // Position position = await UtilMethods().getCurrentLatLong();
      UserModel userModel = UserModel(
        email: email,
        username: '',
        userid: r!.uid,
        profileImage: placeholderDeafultImageUrl,
        bio: 'No Bio',
        fcmToken: '',
        isSeller: false,
        lat: 'position.latitude',
        long: 'position.longitude',
      );
      _userApi.saveUserData(userModel).then((value) {
        value.fold(
          (l) {
            Grock.snackBar(title: 'Error', description: l.message);
          },
          (r) {
            Grock.snackBar(
                title: 'Success', description: 'User Created Successfully');
            context.goNamed(GoRouterConfig.login);
          },
        );
      });
    });
    res.fold(
      (l) => Constants.logger.e(l.toString()),
      (r) => Constants.logger.i(r.toString()),
    );
  }

  // void updateUser(UserModel userModel) async {
  //   state = true;
  //   final res = await _authAPI.updateUser(userModel: userModel);
  //   state = false;
  //   res.fold(
  //     (l) => Constants.logger.e(l.message),
  //     (r) => Constants.logger.i(r),
  //   );
  // }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userApi.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.toMap());
    return updatedUser;
  }

  Future<List<UserModel>> getAllUsers() async {
    final res = await _userApi.getAllUsers();
    return res;
  }

  void signOut(BuildContext context) async {
    state = true;
    await _authAPI.signOut().then(
      (value) {
        if (mounted) {
          context.go(GoRouterConfig.login);
        }
        state = false;
      },
    );
    state = false;
  }
}
