import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final currentPage = StateProvider<int>((ref) => 0);
final themeModeToggle = StateProvider<ThemeMode>(
    (ref) => ThemeMode.light); // Placeholder initial value
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
final userProvider = StateProvider<User?>((ref) {
  return FirebaseAuth.instance.currentUser!;
});
final splashScreenCompleteProvider = StateProvider<bool>((ref) => false);
final googleSignIn = StateProvider<GoogleSignIn>((ref) {
  return GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);
});
