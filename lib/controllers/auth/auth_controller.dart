import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/controllers/database/user_controller.dart';
import 'package:spa_ceylon/models/user_model.dart';
import 'package:spa_ceylon/providers/user_provider.dart';
import 'package:spa_ceylon/screens/auth/auth_screen.dart';
import 'package:spa_ceylon/utils/custom_dialogs.dart';
import 'package:spa_ceylon/utils/navigation_manager.dart';

class AuthController {
  Future<void> signUpUserWithEmail(
    BuildContext context, {
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel myData = UserModel(
        name: name,
        email: email,
        uid: credential.user!.uid,
      );
      Provider.of<UserProvider>(context, listen: false).setCurrentUser(myData);
      await UserController().saveUserData(myData).then((value) {
        Logger().f('User Data Saved');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialogs.showCustomCupertinoDialog(
          context,
          subtitle: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> signOutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      NavigationManager.goWithReplace(context, SigninScreen());
    } catch (e) {
      Logger().e('Failed');
    }
  }

  Future<void> signInUserWithEmail(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (context.mounted) {
          CustomDialogs.showCustomCupertinoDialog(
            context,
            subtitle: 'No user found for that email.',
          );
        }
      } else if (e.code == 'wrong-password') {
        if (context.mounted) {
          CustomDialogs.showCustomCupertinoDialog(
            context,
            subtitle: 'Wrong password provided for that user.',
          );
        }
      }
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      Logger().e('Something went wrong');
    }
  }
}
