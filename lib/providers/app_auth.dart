import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppAuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signUp({
    required String displayName,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      // 1. Create the user
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) {
        _error = 'User creation succeeded but no user was returned.';
        return false;
      }

      // 2. Update Firebase Auth profile
      await user.updateDisplayName(displayName);

      // 3. Reload so that `currentUser.displayName` is up-to-date
      await user.reload();
      final updatedUser = _auth.currentUser;
      assert(updatedUser?.displayName == displayName);

      // // 4. (Optional) Save extra profile info in Firestore
      // await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      //   'displayName': displayName,
      //   'email': email,
      //   'createdAt': FieldValue.serverTimestamp(),
      //   // add more fields here if needed
      // });

      // 5. Clear any previous error and report success
      _error = null;
      return true;
    } on FirebaseAuthException catch (e) {
      // handle Firebase-specific errors
      _error = e.message;
      return false;
    } catch (e) {
      // handle any other errors
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _error = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _auth.signOut();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
