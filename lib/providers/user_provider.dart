import 'package:flutter/material.dart';
import 'package:spa_ceylon/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
}
