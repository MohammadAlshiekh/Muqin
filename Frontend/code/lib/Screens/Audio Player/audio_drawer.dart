import 'package:flutter/material.dart';

class AudioDrawer extends StatelessWidget {
  const AudioDrawer(
      {super.key, required this.songNames, required this.changeSong});
  final List<String> songNames;
  final Function changeSong;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
          itemCount: songNames.length,
          itemBuilder: (context, index) {
           return ListTile(
              title: Text(songNames[index]),
              onTap: () {
                changeSong(index);
                Navigator.of(context).pop();
              },
            );
          }),
    );
  }
}
