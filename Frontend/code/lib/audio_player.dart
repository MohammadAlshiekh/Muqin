// player.dart

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muqin/commons/player_buttons.dart';
import 'package:rxdart/rxdart.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer? _audioPlayer;
  Stream<DurationState>? _durationState;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _audioPlayer!.positionStream,
        _audioPlayer!.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    _audioPlayer
        ?.setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(
          "https://api.storytel.net/assets/consumables/1050289/abook/preview")),
    ]))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "تستمع الآن الى",
              style: Theme.of(context).textTheme.titleLarge,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const Image(
                  image: AssetImage("assets/AhmedShawqi.jpg"),
                  fit: BoxFit.cover,
                  height: 400,
                ),
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Column(children: [
                      Text(
                        "مجنون ليلى",
                        style: Theme.of(context).textTheme.titleLarge,
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        "أحمد شوقي",
                        style: Theme.of(context).textTheme.titleSmall,
                        textDirection: TextDirection.rtl,
                      )
                    ]),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.star_border)),
                  ]),
                  const SizedBox(
                    height: 10,
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
                  const SizedBox(height: 10),
                ],
              ),
            ),
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
