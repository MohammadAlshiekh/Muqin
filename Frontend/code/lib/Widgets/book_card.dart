import 'package:flutter/material.dart';
import 'package:muqin/Screens/epub_text.dart';
import 'package:muqin/models/Book.dart';
import 'package:flutter/services.dart';
import 'package:archive/archive.dart';
import 'dart:typed_data'; // Import for ByteData
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:epubx/epubx.dart';
import 'package:html/parser.dart' as html_parser;

class BookCard extends StatelessWidget {
  const BookCard({super.key, this.book});
  final Book? book;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side content (Text)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                    height: 8), // Add some space between text and buttons
                // Left-aligned Buttons
                SizedBox(
                  height: 40,
                  width: 90,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0.0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 222, 119, 115)),
                      surfaceTintColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => EpubText()));

                      // Handle "اقرا" button action (purchase, etc.)
                    },
                    child: const Text(
                      "إقرا",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  width: 90, // Add some space between buttons
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0.0),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      surfaceTintColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "المزيد",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 78, 80, 108)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  book?.title ?? 'Title',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  book?.author ?? 'Author',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 77, 80, 108),
                  ),
                ),
              ),
            ],
          ),
          // Spacer between text and image
          const SizedBox(width: 16),
          // Right side content (Image)
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://picsum.photos/80'), // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
