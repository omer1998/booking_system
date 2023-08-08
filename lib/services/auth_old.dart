
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class MyFirebaseAuth {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    
  }

  Future<void> signUp(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
        
    
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
