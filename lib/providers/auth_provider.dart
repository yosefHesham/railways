import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:railways/providers/repos/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  AuthRepo _authRepo = AuthRepo();

  Future<void> googleSignIn() async {
    await _authRepo.googleSign();
  }

  Future<void> signUp({String email, String password, String name}) async {
    await _authRepo.signUp(email, password, name);
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
  }

  User get user {
    return FirebaseAuth.instance.currentUser;
  }

  Stream<User> get authState {
    print("authState ${_authRepo.authState()}");
    return _authRepo.authState();
  }
}
