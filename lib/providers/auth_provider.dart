import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/services/auth_service.dart';

class AuthProvider extends ChangeNotifier{
  final AuthService _authService = AuthService();
  User? _user;
  User? get user => _user;

  Stream<User?> get userStream => _authService.userChanges;

  Future<void> signIn() async {
    await _authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}