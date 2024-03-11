import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muqin/Widgets/DrawerWidgets/drawer_widget.dart';
import 'package:muqin/Widgets/book_card.dart';
import 'package:muqin/models/Book.dart';
import 'package:muqin/Widgets/book_of_the_day.dart';
import 'package:muqin/Widgets/image_list.dart';
import 'package:muqin/providers/provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<Book> books = [
    Book(epubPath: '', title: 'Book 1', author: 'Author 1'),
    Book(epubPath: '', title: 'Book 2', author: 'Author 2'),
  ];
  Book bookOfTheDay = Book(epubPath: 'assets/مجنون ليلى.epub');
  final List<String> imageUrls = [
    'https://picsum.photos/800',
    'https://picsum.photos/800',
    'https://picsum.photos/800',
    'https://picsum.photos/800',
    'https://picsum.photos/800',
    'https://picsum.photos/800',
  ];

  PageController _pageController = PageController(viewportFraction: 0.3);
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.3,
      initialPage:
          (imageUrls.length / 2).round(), // Set initial page to the middle
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
          body: SingleChildScrollView(
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
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: EdgeInsets.only(right: 15),
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
                            child: ImageList(
                                pageController: _pageController,
                                imageURLs: imageUrls)),
                        const SizedBox(height: 8),
                        _buildDots(imageUrls.length),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: EdgeInsets.only(right: 15),
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
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: BookCard(book: books[index]),
                            );
                          },
                        ),
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

  Widget _buildDots(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => buildDot(index, ref.watch(currentPage) == index),
      ),
    );
  }

  Widget buildDot(int index, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 10 : 10,
      height: 10,
      decoration: BoxDecoration(
        color:
            isActive ? const Color.fromARGB(255, 222, 119, 115) : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
