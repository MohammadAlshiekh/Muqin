import 'package:flutter/material.dart';

class AudioDrawer extends StatelessWidget {
  const AudioDrawer(
      {super.key, required this.songUrls, required this.changeSong});
  final List<String> songUrls;
  final Function changeSong;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
          itemCount: songUrls.length + 1,
          itemBuilder: (context, index) {
            if (index < songUrls.length) {
              return ListTile(
                title: Text('song ${index + 1}'),
                onTap: () {changeSong(index);
                Navigator.of(context).pop();},
              );
            }
          }),
    );
  }
}
