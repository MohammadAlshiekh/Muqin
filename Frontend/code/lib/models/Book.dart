import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class Book {
  String? title;
  String? author;
  String? genre;
  String? imageUrl;
  String? authorFaceUrl;
  double? rating;
  String? description;
  DateTime? publishedDate;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Book({
    this.title,
    this.author,
    this.genre,
    this.imageUrl,
    this.description,
    this.publishedDate,
    this.authorFaceUrl,
  });
    // Factory constructor to create a Book instance from a map (json)
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      imageUrl: json['imageUrl'],
      authorFaceUrl: json['authorFaceUrl'],
      description: json['description'],
      publishedDate: DateTime.parse(json['publishedDate']),
    );
  }


// Function to parse JSON data into a list of Book objects
// Function to parse JSON data from a file into a list of Book objects
static Future<List<Book>> parseBooksFromFile(String filePath) async {
  final Directory dir = await getApplicationDocumentsDirectory();
  final File file = File('${dir.path}/books.json');
  if(! await file.exists()){

final String response = await rootBundle.loadString(filePath);
  final List<dynamic> jsonData = json.decode(response);
  return jsonData.map((item) => Book.fromJson(item)).toList();
}
else{
      final String response = await file.readAsString();
      final List<dynamic> jsonData = json.decode(response);
      return jsonData.map((item) => Book.fromJson(item)).toList();
}
}
Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'genre': genre,
      'imageUrl': imageUrl,
      'authorFaceUrl': authorFaceUrl,
      'description': description,
      'publishedDate': publishedDate?.toIso8601String(),
    };
  }

  

  
     void openEpub(String filePath, BuildContext context) {
      VocsyEpub.setConfig(
        themeColor: Theme.of(context).primaryColor,
        identifier: "androidBook",
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
      );
      VocsyEpub.open(filePath);
    }
    Future<void> downloadAndOpenEpub(BuildContext context) async {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final File epubFile = File('${appDocDir.path}/$title.epub');
if (! await epubFile.exists()){
        try {
          final epubRef = storage.ref("books/$title.epub");
          await epubRef.writeToFile(epubFile);
          print('EPub downloaded successfully.');
        } catch (e) {
          print('Error downloading ePub file: $e');
          return;
        }
      }

else{
  print('EPub already downloaded.');
}

      openEpub(epubFile.path, context);
    }
     Future<void> downloadAndOpenEpubSummary(BuildContext context) async {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final File epubFile = File('${appDocDir.path}/$title-Summary.epub');
if (! await epubFile.exists()){
        try {
          final epubRef = storage.ref("books/summaries/$title-Summary.epub");
          await epubRef.writeToFile(epubFile);
          print('EPub downloaded successfully.');
        } catch (e) {
          print('Error downloading ePub file: $e');
          return;
        }
      }

else{
  print('EPub already downloaded.');
}

      openEpub(epubFile.path, context);
    }
}
