import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spa_ceylon/controllers/auth/auth_controller.dart';
import 'package:spa_ceylon/screens/home/homepage.dart';
import 'package:spa_ceylon/utils/custom_dialogs.dart';
import 'package:spa_ceylon/utils/navigation_manager.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _userNameController = TextEditingController();
  TextEditingController get userNameController => _userNameController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> startSignUp(BuildContext context) async {
    if (_userNameController.text.trim().isEmpty) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please insert your user name',
      );
    } else if (_emailController.text.trim().isEmpty) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please insert valid email',
      );
    } else if (_passwordController.text.trim().isEmpty ||
        _passwordController.text.length < 6) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please Insert Valid Password',
      );
    } else if (_passwordController.text != _confirmPasswordController.text) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Passwords do not match',
      );
    } else {
      EasyLoading.show();
      await AuthController().signUpUserWithEmail(
        context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _userNameController.text.trim(),
      );
      NavigationManager.goWithReplace(context, HomePage());
      EasyLoading.dismiss();
    }
  }

  Future<void> startSignIn(BuildContext context) async {
    if (_emailController.text.trim().isEmpty) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please insert valid email',
      );
    } else if (_passwordController.text.trim().isEmpty ||
        _passwordController.text.length < 6) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please Insert Valid Password',
      );
    } else {
      EasyLoading.show();
      await AuthController().signInUserWithEmail(
        context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      EasyLoading.dismiss();
      NavigationManager.goWithReplace(context, HomePage());
    }
  }

  Future<void> startSendPasswordResetEmail(BuildContext context) async {
    if (_emailController.text.trim().isEmpty) {
      CustomDialogs.showCustomCupertinoDialog(
        context,
        subtitle: 'Please insert valid email',
      );
    } else {
      EasyLoading.show();
      await AuthController()
          .sendPasswordResetEmail(email: _emailController.text.trim())
          .then((value) {
            if (context.mounted) {
              CustomDialogs.showCustomCupertinoDialog(
                context,
                title: 'Email Sent',
                subtitle: 'Please check your email to reset your password.',
              );
            }
          });
      EasyLoading.dismiss();
    }
  }
}
