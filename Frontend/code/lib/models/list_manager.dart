import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

// Assuming Book and BookList are defined somewhere with toJson() and fromJson() methods.

class ListManager extends StateNotifier<Map<String, BookList>> {
  ListManager() : super({});

  Future<void> saveLists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookLists', json.encode(state.map((key, value) => MapEntry(key, value.toJson()))));
  }

  Future<void> loadLists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? listsString = prefs.getString('bookLists');
    if (listsString != null) {
      Map<String, dynamic> decodedLists = json.decode(listsString);
      state = decodedLists.map((key, value) => MapEntry(key, BookList.fromJson(value)));
    }
  }

  void createList(String listName) {
    if (!state.containsKey(listName)) {
      state = {
        ...state,
        listName: BookList(name: listName, books: [])
      };
      saveLists();
    }
  }

  void deleteList(String listName) {
    if (state.containsKey(listName)) {
      final newState = Map<String, BookList>.from(state);
      newState.remove(listName);
      state = newState;
      saveLists();
    }
  }

  void editListName(String listName, String newName) {
    if (state.containsKey(listName)) {
      final newState = Map<String, BookList>.from(state);
      newState[listName] = BookList(name: newName, books: newState[listName]!.books);
      state = newState;
      saveLists();
    }
  }

  void addBookToList(String listName, Book book) {
    if (state.containsKey(listName)) {
      final newState = Map<String, BookList>.from(state);
      newState[listName] = BookList(
        name: newState[listName]!.name,
        books: List<Book>.from(newState[listName]!.books)..add(book),
      );
      state = newState;
      saveLists();
    }
  }

  void removeBookFromList(String listName, Book book) {
    if (state.containsKey(listName)) {
      final newState = Map<String, BookList>.from(state);
      newState[listName] = BookList(
        name: newState[listName]!.name,
        books: newState[listName]!.books.where((b) => b.title != book.title).toList(),
      );
      state = newState;
      saveLists();
    }
  }

  List<Book>? getBooksInList(String listName) {
    return state[listName]?.books;
  }

  bool containsBook(String listName, Book book) {
    return state[listName]?.books.any((b) => b.title == book.title) ?? false;
  }
}

