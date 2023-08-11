import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';

import '../../common/apis/user_api.dart';
import 'bloc/sign_in_blocs.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  void handleSignIn(String type) async {
    try {
      if (type == "email") {
        // BlocProvider.of<SignInBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        if (emailAddress.isEmpty) {
          toastInfo(msg: "Your need to fill email address");
          return;
        }
        if (password.isEmpty) {
          toastInfo(msg: "Your need to fill password");
          return;
        }

        try {
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
          if (credential.user == null) {
            toastInfo(msg: "Your don't exist");
            return;
          }
          if (!credential.user!.emailVerified) {
            toastInfo(msg: "You need to verify your email account");
            return;
          }

          var user = credential.user;

          if (user != null) {
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            // type 1 means email login
            loginRequestEntity.type = 1;

            print("user exists");
            asyncPostAllData(loginRequestEntity);
            // Global.storageService
            //     .setString(AppConstants.STORAGE_USER_TOKEN_KEY, "12345678");
            // Navigator.of(context)
            //     .pushNamedAndRemoveUntil("/application", (route) => false);
            // we got verified user from firebase
          } else {
            toastInfo(msg: "Currently you are not a user of this app");
            return;
            // we have error getting user from firebase
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print("No user found for that email.");
            toastInfo(msg: "No user found for that email");
            // toastInfo(msg: "No user found for that email.");
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            toastInfo(msg: "Wrong password provided for that user");
            // toastInfo(msg: "Wrong password provided for that user.");
          } else if (e.code == 'invalid-email') {
            print("Your email format is wrong");
            toastInfo(msg: "Your email format is wrong");
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var result = await UserAPI.login(param: loginRequestEntity);
  }
}
