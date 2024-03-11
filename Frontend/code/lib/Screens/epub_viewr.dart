import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class EPUBViewer extends StatefulWidget {
  const EPUBViewer({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<EPUBViewer> {
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('E-pub Viewer'),
        ),
        body: Center(
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      child: const Text('Open Assets E-pub'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

}
