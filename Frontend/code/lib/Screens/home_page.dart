import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muqin/Screens/book_details.dart';
import 'package:muqin/Widgets/DrawerWidgets/drawer_widget.dart';
import 'package:muqin/Widgets/book_card.dart';
import 'package:muqin/models/Book.dart';
import 'package:muqin/Widgets/book_of_the_day.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Book> books = [];
  var bookOfTheDay;
  final FirebaseStorage storage = FirebaseStorage.instance;

  List<String> imageUrls = [];
  parseBooks() async {
    books = await Book.parseBooksFromFile("assets/books.json");
    bookOfTheDay = books[_random.nextInt(books.length)];
    imageUrls = books.map((book) => book.imageUrl!).toList();

    setState(() {});
  }
   
  final _random = Random();

  @override
  void initState() {
    super.initState();
    parseBooks();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        drawer: const DrawerWidget(),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      "assets/log_shape.svg",
                      fit: BoxFit.cover,
                      clipBehavior: Clip.hardEdge,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: deviceWidth / 8,
                        ),
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: SizedBox(
                            height: deviceHeight / 4,
                            width: deviceWidth - deviceWidth / 15,
                            child: BookOfTheDay(book: bookOfTheDay),
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight / 28,
                        ),
                        const Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'مقترحة لك',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 41, 43, 56)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                            height: deviceHeight / 4,
                            width: deviceWidth - deviceWidth / 15,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                                itemCount: books.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) => BookDetails(
                                                  book: books[index])));
                                    },
                                    child: AspectRatio(
                                      aspectRatio: 5/8,
                                      child: Container(
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                books[index].imageUrl!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'الكتب المشهورة',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 41, 43, 56)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        books.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: books.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 25.0),
                                    child: BookCard(book: books[index]),
                                  );
                                },
                              )
                            : const CircularProgressIndicator(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
