// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muqin/Screens/Audio%20Player/audio_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muqin/models/Book.dart';
import 'package:muqin/providers/provider.dart';

class BookDetails extends ConsumerStatefulWidget {
  const BookDetails({super.key, required this.book});
  final Book book;
  @override
  ConsumerState<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends ConsumerState<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final listManager = ref.watch(listManagerProvider.notifier);

    String detectLanguage({required String string}) {
      String languageCodes = 'ar';

      final RegExp english = RegExp(r'^[a-zA-Z]+');
      final RegExp arabic = RegExp(r'^[\u0621-\u064A]+');

      if (english.hasMatch(string)) languageCodes = 'en';
      if (arabic.hasMatch(string)) languageCodes = 'ar';

      return languageCodes;
    }

    // ignore: no_leading_underscores_for_local_identifiers
    void _showAddBookToListDialog(BuildContext context, WidgetRef ref) {
      showDialog(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text('اضف الكتاب لقائمة '),
              content: SizedBox(
                height: 250,
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String listName = listManager.state.keys.elementAt(index);

                    return ListTile(
                      title: Text(listName),
                      onTap: () {
                        if (listManager.containsBook(listName, widget.book!)) {
                          listManager.removeBookFromList(
                              listName, widget.book!);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("تمت ازالة الكتاب من القائمة"),
                          ));
                          Navigator.of(context).pop();
                          return;
                        }
                        listManager.addBookToList(listName, widget.book!);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("تمت اضافة الكتاب الى القائمة"),
                        ));
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  itemCount: listManager.state.keys.length,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('الغاء'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
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
          actions: [
            IconButton(
                onPressed: () {
                  _showAddBookToListDialog(context, ref);
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          widget.book!.downloadAndOpenEpub(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .primary,
                            elevation: 10),
                        child: Text(
                          "اقرأ الكتاب كاملا",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .inversePrimary),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          widget.book!.downloadAndOpenEpubSummary(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .primary,
                            elevation: 10),
                        child: Text(
                          "اقرأ الملخص",textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .inversePrimary),
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => Player(book: widget.book,)));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .primary,
                            elevation: 10),
                        icon: const Icon(Icons.audiotrack)),
                  ),
                ),
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
            SmallCard(
              book: widget.book,
              title: 'المؤلف',
              content: widget.book.author!,
              image: AssetImage(widget.book.authorFaceUrl!),
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

class SmallCard extends ConsumerStatefulWidget {
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
  ConsumerState<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends ConsumerState<SmallCard> {
  @override
  Widget build(BuildContext context) {
    final listManager = ref.watch(listManagerProvider.notifier);
    bool isFavorite = listManager.containsBook("المفضلة", widget.book);

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
                final listManager = ref.watch(listManagerProvider.notifier);

                // Toggle favorite status based on current state
                if (isFavorite) {
                  listManager.removeBookFromList("المفضلة", widget.book);
                  isFavorite = false;
                } else {
                  listManager.addBookToList("المفضلة", widget.book);
                  isFavorite = true;
                }
setState(() {
                isFavorite = isFavorite;
});
              },
              icon: Icon(isFavorite ? Icons.star : Icons.star_border),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                Text(widget.content,
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
                  image: widget.image,
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
