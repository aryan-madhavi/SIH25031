import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthHelper {
  String FirebaseHelper(FirebaseException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'The provided login credentials are incorrect or malformed. Please check your email and password.';
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';
      case 'weak-password':
        return 'Please enter a stronger password (at least 6 characters).';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'invalid-email':
        return 'The provided email address is invalid.';
      case 'invalid-password':
        return 'The provided email address is invalid.';
      case 'invalid-verification-code':
        return 'The provided Verfication code is invalid';
      case 'nvalid-verification-id':
        return 'The provided Verfication Id is invalid';
      case 'invalid-phone-number':
        return 'The provided Phone Number is invalid';
      case 'phone-number-already-exists':
        return 'The provided Phone Number is invalid';
      default:
        return 'Unexpected Error ${e.message}';
    }
  }
}
