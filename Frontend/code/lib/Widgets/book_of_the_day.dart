import 'package:flutter/material.dart';
import 'package:muqin/models/Book.dart';
import 'package:muqin/Screens/book_details.dart';

class BookOfTheDay extends StatelessWidget {
  final Book? book;

  const BookOfTheDay({super.key, this.book});

  @override
  Widget build(BuildContext context) {
    if (book == null) return Container(); // Handle book absence
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book!.title!,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 78, 80, 108), fontSize: 26),
                ),
                Expanded(
                  child: Text(
                    book!.description!,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 144, 145, 160),
                        overflow: TextOverflow.fade),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0.0),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            surfaceTintColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => BookDetails(book: book!)));
                          },
                          child: const Text(
                            "المزيد",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 78, 80, 108)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0.0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 222, 119, 115)),
                            surfaceTintColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                          ),
                          onPressed: () {
book!.downloadAndOpenEpub(context);                          },
                          child: const Text(
                            "إقرا",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          AspectRatio(
            aspectRatio: 5/8,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: AssetImage(book!.imageUrl!), fit: BoxFit.cover)),
            ),
          ),
        ],
      ),
    );
  }
}
