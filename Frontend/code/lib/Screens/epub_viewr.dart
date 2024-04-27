import 'dart:convert';
import 'dart:io';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("EPUB Reader"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.layers),
            onPressed: () => _showOverlay(context),
          ),
        ],
      ),
      body: SelectionArea(
        child: FutureBuilder(
          future: VocsyEpub.openAsset(
            'assets/ml.epub',
            lastLocation: null,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                child: Text('EPUB is now being displayed'),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Overlay Title'),
          content: const Text('This is an overlay.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
