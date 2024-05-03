import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class EPUBViewer extends StatefulWidget {
  const EPUBViewer({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
