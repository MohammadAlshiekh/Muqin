import "dart:io";

import "package:epubx/epubx.dart";
import 'package:html/parser.dart' as html_parser;

class Book {
  String epubPath;
  String? title;
  String? author;
  String? genre;
  String? imageUrl;
  double? price;
  double? rating;
  String? description;
  DateTime? publishedDate;
  String? isbn;

  Book({
    required this.epubPath,
    this.title,
    this.author,
    this.genre,
    this.imageUrl,
    this.price,
    this.rating,
    this.description,
    this.publishedDate,
    this.isbn,
  });

  static PrepareBook(String epubPath) async {
    var targetFile = File(epubPath);
    List<int> bytes = await targetFile.readAsBytes();
    EpubBook epubBook = await EpubReader.readBook(bytes);

    // Book's title
    String? title = epubBook.Title;

    // Book's authors (comma separated list)
    String? author = epubBook.Author;

    // Book's cover image (null if there is no cover)
    Image? coverImage = epubBook.CoverImage;

    return {title, author, coverImage};
  }
}

Future<void> readEpub(String filePath) async {
  File file = File(filePath);
  List<int> bytes = await file.readAsBytes();
  EpubBook epubBook = await EpubReader.readBook(bytes);

  // Now you can access the content
  print("Title: ${epubBook.Title}");
  List<EpubChapter> chapters = epubBook.Chapters ?? [];

  for (EpubChapter chapter in chapters) {
    print("Chapter Title: ${chapter.Title}");
    print("Chapter Content: ${chapter.HtmlContent}");
    extractTextFromHtml(chapter.HtmlContent);
  }
}

void extractTextFromHtml(String? htmlContent) {
  var document = html_parser.parse(htmlContent);
  String? text = document.body?.text;
  print("Extracted text: $text");
}
