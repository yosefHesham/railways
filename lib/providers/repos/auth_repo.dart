import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:railways/helpers/googleSign_exception.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;

  Future<void> googleSign() async {
    try {
      final googleSign = GoogleSignIn();
      final googleAccount = await googleSign.signIn();

      print(googleAccount.displayName);
      if (googleAccount == null) {
        throw GoogleException("Cancelled by user");
      }
      final googleSignIn = await googleAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignIn.idToken, accessToken: googleSignIn.accessToken);
      final user = await _auth.signInWithCredential(credential);
      await _storeUserData(user.user);
    } catch (e) {
      print("Error : ${e.toString()}");
      throw GoogleException("Error While Loggin in");
    }
  }

  // Future<AuthblocState> signIn(String email, String password) async {
  //   AuthblocState authState = AuthblocInitial();
  //   try {
  //     UserCredential authResult = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     final User user = authResult.user;
  //     print("name:: ${user.displayName}");
  //     authState = SignedInState(user);
  //   } catch (e) {
  //     authState = AuthErrorState("error while trying to login !");
  //   }
  //   return authState;
  // }

  Future<void> signUp(String email, String password, String name) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _auth.currentUser.updateDisplayName(name);

      await _storeUserData(user.user);
    } catch (e) {
      var errorMsg = "Error While trying to sign up !";
      if (e.toString().contains("in use")) {
        errorMsg = "This Mail Is Already In Use";
        throw GoogleException(errorMsg);
      }
    }
  }

  Future<void> signOut() async {
    final googleSign = GoogleSignIn();
    if (await googleSign.isSignedIn()) {
      await googleSign.signOut();
    }

    await _auth.signOut();
  }

  Future<void> _storeUserData(User user) async {
    await FirebaseFirestore.instance.collection('profiles').doc(user.uid).set({
      "name": user.displayName,
      "email": user.email,
      "imgUrl": user.photoURL
    });
  }

  Stream<User> authState() {
    return _auth.authStateChanges();
  }
}
