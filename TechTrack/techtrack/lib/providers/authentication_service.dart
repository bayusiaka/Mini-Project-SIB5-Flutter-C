import 'package:flutter/material.dart';
import 'package:techtrack/helper/database_helper.dart';
import 'package:techtrack/models/user_model.dart';

class AuthenticationService extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> login(UserModel userModel) async {
    final db = DatabaseHelper();
    final isLoginSuccess = await db.login(userModel);
    if (isLoginSuccess) {
      _user = userModel;
    }
  }

  void setUser(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }

  void logout() {
    _user = null;
  }
}