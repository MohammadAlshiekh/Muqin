import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muqin/models/list_manager.dart';

class BookListCard extends StatelessWidget {
  const BookListCard({super.key, required this.bookList, this.imageUrl});
  final BookList bookList;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return 
       Container(
        height: MediaQuery.of(context).size.height * 0.125,
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
        child: Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
          
            children:  [
              Image.asset(imageUrl!),
              const SizedBox(width: 8,)
              ,Text(bookList.name,style: GoogleFonts.vazirmatn(
                  textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),)
            ],
          ),
        ),
      );
  }
}
