import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muqin/Screens/Drawer%20Screens/Book%20Lists/book_list.dart';
import 'package:muqin/Widgets/book_list_card.dart';
import 'package:muqin/providers/provider.dart';

class BookListsScreen extends ConsumerWidget {
  const BookListsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listManager = ref.watch(listManagerProvider);
    final bookLists = listManager.bookLists.values.toList();

    void _showAddListDialog(BuildContext context, WidgetRef ref) {
      TextEditingController listNameController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('اضف قائمة جديدة'),
            content: TextField(
              controller: listNameController,
              decoration: const InputDecoration(hintText: "أدخل اسم القائمة"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('الغاء'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('اضف'),
                onPressed: () {
                  listManager.createList(listNameController.text);
                  ref.refresh(listManagerProvider);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("قوائم القراءة"),
        actions: [
          IconButton(
              onPressed: () {
                _showAddListDialog(context, ref);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: listManager.bookLists.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(bookLists[index].name),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                listManager.deleteList(bookLists[index].name);
                ref.refresh(listManagerProvider);
              },
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          BookListScreen(bookListName: bookLists[index].name)));
                },
                child: BookListCard(
                  bookList: bookLists[index],
                  imageUrl: bookLists[index].books.isNotEmpty
                      ? bookLists[index].books[0].imageUrl
                      : "assets/defaultCover.png",
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
