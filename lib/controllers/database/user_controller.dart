import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/models/user_model.dart';
import 'package:spa_ceylon/providers/user_provider.dart';
import 'package:spa_ceylon/screens/home/homepage.dart';
import 'package:spa_ceylon/utils/navigation_manager.dart';

class UserController {
  CollectionReference userCollection = FirebaseFirestore.instance.collection(
    'Users',
  );

  Future<void> saveUserData(UserModel user) async {
    try {
      await userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      Logger().e('Error  - $e');
    }
  }

  Future<void> getUserData(BuildContext context) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      final data = await userCollection.doc(uid).get();
      final userData = data.data();
      final userModel = UserModel.fromJson(userData as Map<String, dynamic>);
      if (context.mounted) {
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).setCurrentUser(userModel);
        NavigationManager.goWithReplace(context, HomePage());
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
