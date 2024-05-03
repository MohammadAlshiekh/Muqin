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
    final listener = ref.listen(listManagerProvider, (previous, next) { ref.refresh(listManagerProvider);});
    final listManager = ref.watch(listManagerProvider);
    final List<Book> books = listManager.getBooksInList(bookListName)!;
    return Scaffold(
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
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: BookCard(book: books[index]),
                  );
                },
              )
            : const Center(child: Text("أضف كتب للقائمة لتستطيع مشاهدتها")),
      ),
    );
  }
}
