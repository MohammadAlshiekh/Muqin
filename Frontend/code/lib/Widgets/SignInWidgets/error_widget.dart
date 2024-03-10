import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.error});
final error;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error.toString()));
  }
}