import 'dart:convert';

import 'package:muqin/models/Book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookList {
  String name;
  List<Book> books;

  BookList({
    required this.name,
    required this.books,
  });

  void addBook(Book book) {
    if (!books.contains(book)) {
      books.add(book);
    }
  }

  void removeBook(Book book) {
    books.remove(book);
  }

  factory BookList.fromJson(Map<String, dynamic> json) {
    return BookList(
      name: json['name'],
      books: (json['books'] as List)
          .map((bookJson) => Book.fromJson(bookJson))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'books': books.map((book) => book.toJson()).toList(),
    };
  }
}

class ListManager {
  Map<String, BookList> bookLists = {
    "المفضلة": BookList(name: "المفضلة", books: [])
  };

  Future<void> saveLists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> encodedLists =
        bookLists.map((key, value) => MapEntry(key, value.toJson()));
    await prefs.setString('bookLists', json.encode(encodedLists));
  }

  Future<void> loadLists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? listsString = prefs.getString('bookLists');
    if (listsString != null) {
      Map<String, dynamic> decodedLists = json.decode(listsString);
      bookLists = decodedLists
          .map((key, value) => MapEntry(key, BookList.fromJson(value)));
    }
  }

  void createList(String listName) {
    if (!bookLists.containsKey(listName)) {
      bookLists[listName] = BookList(name: listName, books: []);
      saveLists();
    }
  }

  void deleteList(String listName) {
    bookLists.remove(listName);
    saveLists();
  }

  void editListName(String listName, String newName) {
    if (bookLists.containsKey(listName)) {
      bookLists[listName]!.name = newName;
      saveLists();
    }
  }

  void addBookToList(String listName, Book book) {
    if (bookLists.containsKey(listName)) {
      bookLists[listName]!.addBook(book);
      saveLists();
    }
  }

  void removeBookFromList(String listName, Book book) {
    if (bookLists.containsKey(listName)) {
      bookLists[listName]!.removeBook(book);
      saveLists();
    }
  }

  List<Book>? getBooksInList(String listName) {
    return bookLists[listName]?.books;
  }

  bool containsBook(String listName, Book book) {
    if (bookLists.containsKey(listName)) {
      return bookLists[listName]!.books.any((b) => b.title == book.title);
    }
    return false;
  }
}
