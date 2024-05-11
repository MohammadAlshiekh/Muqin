// ignore_for_file: unused_result, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muqin/Widgets/book_card.dart';
import 'package:muqin/models/Book.dart';
import 'package:muqin/providers/provider.dart';

class BookListScreen extends ConsumerWidget {
  const BookListScreen({super.key, required this.bookListName});
  final String bookListName;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final l = ref.watch(listManagerProvider);
    final listManager = ref.watch(listManagerProvider.notifier);
    final books = ref.watch(listManagerProvider.select(
      (manager) => manager[bookListName]!.books ?? []
    ));    return Scaffold(
      appBar: AppBar(
        title: Text(bookListName),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: books.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Dismissible(
              key: Key(books[index].title!),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                listManager.removeBookFromList(bookListName, books[index]);
              }, child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: BookCard(book: books[index]),
                  ));
                },
              )
            : const Center(child: Text("أضف كتب للقائمة لتستطيع مشاهدتها")),
      ),
    );
  }
}
