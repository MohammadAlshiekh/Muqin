import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muqin/commons/player_buttons.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer? _audioPlayer;
  Stream<DurationState>? _durationState;

  Future<String> saveByteStreamToFile(
      Uint8List byteStream, String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/$fileName');
    await file.writeAsBytes(byteStream);
    return file.path;
  }

  Future<void> fetchAndPlayAudio() async {
    var url = Uri.parse(
        'https://api.elevenlabs.io/v1/text-to-speech/zQo9qeBB5nH9mvipJq2Q');
    var headers = {
      'Content-Type': 'application/json',
      'xi-api-key': '3ddc7e4cc3c00ff9d861127b2b481357',
    };
    var body = json.encode({
      "voice_settings": {"stability": 0.5, "similarity_boost": 0.5},
      "text":
          "السلام عليكم معكم محمد عبده وأنتم تستعملون تطبيق موقن للكتب العربية. أتمنى لكم وقتاً ممتع.",
      "model_id": "eleven_multilingual_v2"
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Uint8List audioData = response.bodyBytes;
        String filePath =
            await saveByteStreamToFile(audioData, 'downloadedAudio.mp3');
        await _audioPlayer?.setFilePath(filePath);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer?.setFilePath('assets/combined_audio.mp3');

    // // Fetch and attempt to play the audio
    // fetchAndPlayAudio().catchError((error) {
    //   print("An error occurred during audio fetch and play: $error");
    // });

    // Combine streams to update UI accordingly
    _durationState =
        Rx.combineLatest3<Duration, Duration?, PlaybackEvent, DurationState>(
      _audioPlayer!.positionStream,
      _audioPlayer!.durationStream,
      _audioPlayer!.playbackEventStream,
      (position, totalDuration, playbackEvent) => DurationState(
        progress: position,
        buffered: playbackEvent.bufferedPosition,
        total: totalDuration ?? Duration.zero,
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery for responsive design
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenWidth,
                    width: screenWidth * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/AhmedShawqi.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.star_border),
                      ),
                      const Column(
                        children: [
                          Text(
                            "تستمع الآن الى",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            "مجنون ليلى",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder<DurationState>(
              stream: _durationState,
              builder: (context, snapshot) {
                final durationState = snapshot.data;
                final progress = durationState?.progress ?? Duration.zero;
                final buffered = durationState?.buffered ?? Duration.zero;
                final total = durationState?.total ?? Duration.zero;
                return ProgressBar(
                  progress: progress,
                  buffered: buffered,
                  total: total,
                  onSeek: (duration) {
                    _audioPlayer?.seek(duration);
                  },
                );
              },
            ),
            PlayerButtons(_audioPlayer!),
            const SizedBox(height: 20), // Adds some spacing at the very bottom
          ],
        ),
      ),
    );
  }
}

class DurationState {
  const DurationState({this.progress, this.buffered, this.total});
  final Duration? progress;
  final Duration? buffered;
  final Duration? total;
}
