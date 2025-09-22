import 'package:civic_reporter/App/Core/firebase/firebase_auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final bool success;
  final String message;

  AuthResult({required this.success, required this.message});
}

class AuthRepository extends FirebaseAuthHelper {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFireStore,
  }) : _auth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firebaseFireStore ?? FirebaseFirestore.instance;

  //  Login
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final usr = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(
        success: usr.user != null,
        message: usr.user != null ? "Login successful" : "User not found",
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, message: FirebaseHelper(e));
    }
  }

  //  Register
  Future<AuthResult> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final usr = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (usr.user != null) {
        await usr.user!.updateDisplayName(name);

        await _firestore.collection('users').doc(usr.user!.uid).set({
          'uid' : usr.user!.uid,
          'name': name,
          'email': email,
          'created': FieldValue.serverTimestamp(),
          'role' : 'user',
          'totalreports' : 0
        });

        return AuthResult(
          success: true,
          message: "User registered successfully",
        );
      }
      return AuthResult(success: false, message: "User is null");
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, message: FirebaseHelper(e));
    }
  }

  // Google Sign-in
  // Future<AuthResult> signInWithGoogle() async {
  //   try {
  //     final googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       return AuthResult(success: false, message: "User cancelled sign-in");
  //     }
  //     final googleAuth = await googleUser.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     await _auth.signInWithCredential(credential);
  //     return AuthResult(success: true, message: "Google sign-in successful");
  //   } on FirebaseAuthException catch (e) {
  //     return AuthResult(success: false, message: FirebaseHelper(e));
  //   }
  // }

  //  Password reset
  Future<AuthResult> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResult(success: true, message: "Password reset email sent");
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, message: FirebaseHelper(e));
    }
  }

  //  Sign-out
  Future<void> signOut() async {
    await _auth.signOut();
    //await GoogleSignIn().signOut();
  }

  //  Current user
  User? get currentUser => _auth.currentUser;
}