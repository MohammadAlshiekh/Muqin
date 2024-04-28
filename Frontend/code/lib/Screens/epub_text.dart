import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:archive/archive.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:muqin/models/AutoDirectonText.dart';

class EpubText extends StatefulWidget {
  @override
  _EpubTextState createState() => _EpubTextState();
}

class _EpubTextState extends State<EpubText> {
  // Audio player
  late AudioPlayer _audioPlayer;
  bool _isPlayingAudio = false;
  //page number
  ScrollController _scrollController = ScrollController();
  double _previousScrollPosition = 0;
  String assetPath = 'assets/majnoon_laila.epub';

  String extractedText = "";
  int currentPage = 1;
  int totalPage = 1; // Initialized to 1; will be calculated later
  Timer? _debounce;
  Future<void> readEpubFromAssets(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    Archive archive = ZipDecoder().decodeBytes(bytes);
    for (ArchiveFile file in archive) {
      String fileName = file.name;
      if (fileName.contains('.xhtml') || fileName.contains('.html')) {
        var content = utf8.decode(file.content);
        extractedText += content; // Append XHTML content
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    // Optionally set an audio file
    _setAudioFile('assets/combined_audio.mp3');
    readEpubFromAssets(assetPath);
    // _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // The scroll stopped for 500 milliseconds, calculate the page
      _calculatePageNumber();
    });
  }

  void _calculatePageNumber() {
    // Get the current scroll position and the height of the viewport
    final double currentScrollPosition = _scrollController.position.pixels;
    final double viewportHeight = _scrollController.position.viewportDimension;

    // Calculate the current page
    final int newPage = (currentScrollPosition / viewportHeight).floor() + 1;

    // Check if the page number actually changed
    if (currentPage != newPage) {
      setState(() {
        currentPage = newPage;
      });
    }

    // If you also need to calculate the total number of pages (less frequently):
    final double contentHeight =
        _scrollController.position.maxScrollExtent + viewportHeight;
    final int newTotalPages = (contentHeight / viewportHeight).ceil();
    if (totalPage != newTotalPages) {
      setState(() {
        totalPage = newTotalPages;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _debounce?.cancel();
    _scrollController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

//////////////////////////////////////////////////////// audio player functions ////////////////////////////////////////////////////
  void _setAudioFile(String filePath) async {
    await _audioPlayer.setAsset(filePath);
    setState(() {}); // Update the UI after loading the audio
  }

  void _toggleAudioPlayback() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    setState(() {
      _isPlayingAudio = _audioPlayer.playing;
    });
  }

  void _toggleAudioMode() async {
    // If audio mode is not active, set up the audio file and start playing
    if (!_isPlayingAudio) {
      await _audioPlayer.setAsset('assets/combined_audio.mp3');
      _audioPlayer.play();
      setState(() {
        _isPlayingAudio = true;
      });
    } else {
      // If audio is already playing, stop it and revert to text mode
      await _audioPlayer.stop();
      setState(() {
        _isPlayingAudio = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 238, 247),
      appBar: AppBar(
        title: Align(
          child: AutoDirectionText("مجنون ليلى"),
          alignment: AlignmentDirectional.center,
        ),
        surfaceTintColor: Color.fromARGB(255, 241, 238, 247),
        backgroundColor: Color.fromARGB(255, 241, 238, 247),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black), // Change to appropriate icon
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(
                  context); // This will take the user back to the previous screen
            } else {
              // doing nothing.
            }
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.bookmark_border,
        //         color: Colors.black), // Change to appropriate icon
        //     onPressed: () {
        //       // Handle bookmark action
        //     },
        //   ),
        // ],
      ),
      body: Container(
        color: Color.fromARGB(255, 241, 238, 247),
        padding: EdgeInsets.all(16.0), // Adjust padding for comfortable reading
        child: SingleChildScrollView(
          // controller: _scrollController,
          child: SelectionArea(
            child: Html(
              data: extractedText,
              style: {
                'body': Style(
                  color: Colors.black, // Text color
                  textAlign: TextAlign.start,
                  direction: TextDirection.rtl,
                  lineHeight: LineHeight.em(1.5),
                  fontSize: FontSize(
                      18.0), // Adjust font size to match the screenshot
                ),
                'p': Style(
                  padding: HtmlPaddings.only(bottom: 10.0),
                ),
                // Add styles for other HTML tags as needed
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: _isPlayingAudio
          ? BottomAppBar(
              color: Color.fromARGB(255, 241, 238, 247),
              elevation: 0,
              height: 150,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: IconButton(
                    iconSize: 50,
                    icon: Icon(
                      _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                    ),
                    onPressed: _toggleAudioPlayback,
                  )),
                  Flexible(
                      flex: 3,
                      child: StreamBuilder<Duration>(
                        stream: _audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final bufferedPosition =
                              _audioPlayer.bufferedPosition;
                          final totalDuration =
                              _audioPlayer.duration ?? Duration.zero;
                          return ProgressBar(
                            progress: position,
                            buffered: bufferedPosition,
                            total: totalDuration,
                            onSeek: (duration) {
                              _audioPlayer.seek(duration);
                            },
                          );
                        },
                      )),
                ],
              ),
            )
          : BottomAppBar(
              color: Color.fromARGB(255, 241, 238, 247),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text("Page $currentPage of $totalPage",  Disabled due to performance issues.
                    //     style: TextStyle(color: Colors.black)),
                    IconButton(
                      icon: Icon(Icons.multitrack_audio_rounded,
                          color: Colors.black), // Change to appropriate icon
                      onPressed: _toggleAudioMode,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
