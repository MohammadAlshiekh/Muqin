import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muqin/Book.dart';
import 'package:muqin/Sign_up.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final List<Book> books = [
    Book(epubPath: '', title: 'Book 1', author: 'Author 1'),
    Book(epubPath: '', title: 'Book 2', author: 'Author 2'),
    // Add more books as needed
  ];
  Book bookOfTheDay = new Book(epubPath: 'assets/مجنون ليلى.epub');
  final List<String> imageUrls = [
    'https://picsum.photos/800',
    'https://picsum.photos/800',
    'https://picsum.photos/800',
    'https://picsum.photos/800',
    'https://picsum.photos/800',
    'https://picsum.photos/800',
    // Add more image URLs as needed
  ];

  PageController _pageController = PageController(viewportFraction: 0.3);
  int _currentPage = 0;
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.3,
      initialPage:
          (imageUrls.length / 2).round(), // Set initial page to the middle
    );
    _currentPage = (_pageController.initialPage ?? 0).toInt();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                  child: _buildBookOfTheDay(bookOfTheDay),
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
                        fontSize: 18, color: Color.fromARGB(255, 41, 43, 56)),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  height: deviceHeight / 4,
                  width: deviceWidth - deviceWidth / 15,
                  child: _buildImageList()),
              SizedBox(height: 8),
              _buildDots(imageUrls.length),
              SizedBox(height: 16),
              const Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    'الكتب المشهورة',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 41, 43, 56)),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: _buildBookCard(books[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookOfTheDay(Book? book) {
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
                  book.title ?? 'مجنون ليلى',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 78, 80, 108), fontSize: 26),
                ),
                Expanded(
                  child: Text(
                    book.description ??
                        "The psychology of money is the study of our behavior with money. Success with money isn't about knowledge, IQ or how good you are at math. It's about behavior, and everyone is prone to certain behaviors over others.'",
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
                            // Handle "المزيد" button action (show more info, etc.)
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
                            // Handle "اقرا" button action (purchase, etc.)
                          },
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
          const Image(
            image: AssetImage('assets/AhmedShawqi.jpg'),
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildImageList() {
    return Container(
      height: 200, // Set the height as needed
      child: PageView.builder(
        controller: _pageController,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _handleImageTap(index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }

  void _handleImageTap(int index) {
    // Handle the tap event for the image at the specified index
    print('Tapped on image at index $index');
    // Add your custom logic here
  }

  Widget _buildDots(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => buildDot(index, _currentPage == index),
      ),
    );
  }

  Widget buildDot(int index, bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 10 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? Color.fromARGB(255, 222, 119, 115) : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildBookCard(Book book) {
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
                SizedBox(height: 8), // Add some space between text and buttons
                // Left-aligned Buttons
                SizedBox(
                  height: 40,
                  width: 90,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0.0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 222, 119, 115)),
                      surfaceTintColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Handle "اقرا" button action (purchase, etc.)
                    },
                    child: Text(
                      "إقرا",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8),
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
                    child: Text(
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
                  book.title ?? 'Title',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  '${book.author ?? 'Author'}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 77, 80, 108),
                  ),
                ),
              ),
            ],
          ),
          // Spacer between text and image
          SizedBox(width: 16),
          // Right side content (Image)
          Container(
            width: 80, // Set your desired width
            height: 120, // Set your desired height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
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
