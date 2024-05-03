import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muqin/Screens/Audio%20Player/audio_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muqin/models/Book.dart';
import 'package:muqin/providers/provider.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.book});
  final Book? book;
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    String detectLanguage({required String string}) {
      String languageCodes = 'ar';

      final RegExp english = RegExp(r'^[a-zA-Z]+');
      final RegExp arabic = RegExp(r'^[\u0621-\u064A]+');

      if (english.hasMatch(string)) languageCodes = 'en';
      if (arabic.hasMatch(string)) languageCodes = 'ar';

      return languageCodes;
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          title: Text(
            widget.book!.title!,
            style: GoogleFonts.vazirmatn(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(23, 27, 54, 1),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      widget.book!.downloadAndOpenEpub(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                        elevation: 10),
                    child: Text(
                      "اقرأ الكتاب كاملا",
                      style: TextStyle(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .inversePrimary),
                    )),
                ElevatedButton(
                    onPressed: () {
                      widget.book!.downloadAndOpenEpub(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                        elevation: 10),
                    child: Text(
                      "اقرأ الملخص",
                      style: TextStyle(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .inversePrimary),
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => const Player()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                        elevation: 10),
                    icon: const Icon(Icons.audiotrack)),
              ],
            ),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                Align(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        color: const Color.fromRGBO(23, 27, 54, 1),
                        border: Border.all(
                            color: const Color.fromRGBO(23, 27, 54, 1.000),
                            strokeAlign: BorderSide.strokeAlignInside,
                            width: 10)),
                    clipBehavior: Clip.hardEdge,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.1,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(widget.book!.imageUrl!),
                                    fit: BoxFit.cover))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: SmallCard(
                book: widget.book!,
                title: 'المؤلف',
                content: widget.book!.author!,
                image: AssetImage(widget.book!.authorFaceUrl!),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "عن الكتاب:",
                        style: GoogleFonts.vazirmatn(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(77, 80, 108, 1),
                                fontSize: 24)),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    Text(
                      widget.book!.description!,
                      style: GoogleFonts.vazirmatn(
                          color: const Color.fromRGBO(109, 110, 121, 1),
                          fontSize: 16),
                      textDirection:
                          detectLanguage(string: widget.book!.description!) ==
                                  "en"
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                    ),
                  ]),
            ),
          ],
        ));
  }
}

class SmallCard extends ConsumerWidget {
  final Book book;
  final String title;
  final String content;
  final AssetImage image;
  const SmallCard(
      {super.key,
      required this.book,
      required this.title,
      required this.content,
      required this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listManager = ref.watch(listManagerProvider);
    bool isFavorite = listManager.containsBook("المفضلة", book);

    return Card(
      elevation: 3, // Set the elevation (shadow) of the card
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                // Toggle favorite status based on current state
                if (isFavorite) {
                  ref
                      .read(listManagerProvider)
                      .removeBookFromList("المفضلة", book);
                } else {
                  ref.read(listManagerProvider).addBookToList("المفضلة", book);
                }
                ref.refresh(listManagerProvider);
              },
              icon: Icon(isFavorite ? Icons.star : Icons.star_border),
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                Text(content,
                    style: const TextStyle(fontSize: 16),
                    textDirection: TextDirection.rtl),
              ],
            ),
            const SizedBox(width: 16),
            ClipOval(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image(
                  image: image,
                  fit: BoxFit
                      .cover, // BoxFit to cover the entire circular container
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
