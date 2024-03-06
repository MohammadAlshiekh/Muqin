import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPage = StateProvider<int>((ref) => 0);
final themeModeToggle = StateProvider<ThemeMode>((ref) => ThemeMode.light); // Placeholder initial value


