import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class Book {
  String epubPath;
  String firebaseUrl;  // URL in Firebase Storage
  String? title;
  String? author;
  String? genre;
  String? imageUrl;
  String? authorFaceUrl;
  double? rating;
  String? description;
  DateTime? publishedDate;
  bool? downloaded;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Book({
    required this.epubPath,
    this.firebaseUrl = '',
    this.title,
    this.author,
    this.genre,
    this.imageUrl,
    this.description,
    this.publishedDate,
    this.downloaded = false,
    this.authorFaceUrl,
  });
    // Factory constructor to create a Book instance from a map (json)
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      epubPath: json['epubPath'],
      firebaseUrl: json['firebaseUrl'],
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      imageUrl: json['imageUrl'],
      authorFaceUrl: json['authorFaceUrl'],
      description: json['description'],
      publishedDate: DateTime.parse(json['publishedDate']),
      downloaded: json['downloaded'],
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
      'epubPath': epubPath,
      'firebaseUrl': firebaseUrl,
      'title': title,
      'author': author,
      'genre': genre,
      'imageUrl': imageUrl,
      'authorFaceUrl': authorFaceUrl,
      'description': description,
      'publishedDate': publishedDate?.toIso8601String(),
      'downloaded': downloaded,
    };
  }

  static Future<void> downloadBookFromFirebase(Book book) async {
    if (book.downloaded ?? false) {
      print("Book already downloaded.");
      return;
    }

    final Reference ref = FirebaseStorage.instance.refFromURL(book.firebaseUrl);
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/${book.title}.epub');

    if (!file.existsSync()) {
      await ref.writeToFile(file);
      book.epubPath = file.path;
      book.downloaded = true;
      print("Download completed: ${file.path}");
    } else {
      print("File already exists locally.");
    }
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
      if (epubPath != epubFile.path) {
        try {
          epubPath = epubFile.path;
          final epubRef = storage.ref("books/$title.epub");
          await epubRef.writeToFile(epubFile);
          print('EPub downloaded successfully.');
        } catch (e) {
          print('Error downloading ePub file: $e');
          return;
        }
      } else {
        print('EPub already downloaded.');
      }
}
else{
  epubPath =  epubFile.path;
  print('EPub already downloaded.');
}

      openEpub(epubPath, context);
    }
}
