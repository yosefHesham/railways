import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:railways/providers/repos/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  AuthRepo _authRepo = AuthRepo();

  User get user {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> googleSignIn() async {
    await _authRepo.googleSign();
  }

  Future<void> signUp({String email, String password, String name}) async {
    await _authRepo.signUp(email, password, name);
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    await _authRepo.deleteAccount();
    notifyListeners();
  }

  Future<void> updateName(String name) async {
    await _authRepo.updateName(name);
    notifyListeners();
  }

  Future<void> updateMail(String mail) async {
    await _authRepo.updateMail(mail);
    notifyListeners();
  }

  Stream<User> get authState {
    print("authState ${_authRepo.authState()}");
    return _authRepo.authState();
  }
}
