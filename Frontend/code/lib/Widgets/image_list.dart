import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muqin/providers/provider.dart';

class ImageList extends ConsumerWidget {
  final PageController pageController;
  final List<String> imageURLs;
  const ImageList(
      {super.key, required this.pageController, required this.imageURLs});
  void _handleImageTap(int index) {
    // Handle the tap event for the image at the specified index
    print('Tapped on image at index $index');
    // Add your custom logic here
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 200, // Set the height as needed
      child: PageView.builder(
        controller: pageController,
        itemCount: imageURLs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _handleImageTap(index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.network(
                imageURLs[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        onPageChanged: (index) {
          ref.read(currentPage.notifier).state = index;
        },
      ),
    );
  }
}
