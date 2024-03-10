import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPage = StateProvider<int>((ref) => 0);
final themeModeToggle = StateProvider<ThemeMode>((ref) => ThemeMode.light); // Placeholder initial value
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
final userProvider = StateProvider<User?>((ref) {
  return FirebaseAuth.instance.currentUser!;
});
final splashScreenCompleteProvider = StateProvider<bool>((ref) => false);

