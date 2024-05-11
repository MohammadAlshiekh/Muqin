import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:muqin/Screens/Audio%20Player/audio_drawer.dart';
import 'package:muqin/models/Book.dart';
import 'package:path_provider/path_provider.dart';

class Player extends StatefulWidget {
  const Player({super.key, required this.book});
  final Book book;
  @override
  // ignore: library_private_types_in_public_api
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer player;
  List<String> songUrls = []; // This will hold our song URLs
  List<String> songNames = []; // This will hold our song names

  int currentSongIndex = 0; // Track current song index
  Future<void> fetchBooks() async {
    final ref = FirebaseStorage.instance
        .ref('audiobooks/${widget.book.title}/'); // adjust the path
    final result = await ref.listAll();
    final urls = await Future.wait(result.items.map((e) => e.getDownloadURL()));
    final names = result.items.map((e) => e.name.split('.').first).toList();

    setState(() {
      songUrls = urls;
      songNames = names;
      if (songUrls.isNotEmpty) {
        player.setSourceUrl(songUrls[currentSongIndex]);
      }
    });
  }

  void previousBook() {
    if (currentSongIndex > 0) {
      changeSong(currentSongIndex - 1);
    }
  }

  void nextBook() {
    if (currentSongIndex < songUrls.length - 1) {
      changeSong(currentSongIndex + 1);
    }
  }

  void changeSong(int index) async {
    if (index >= 0 && index < songUrls.length) {
      await player.setSourceUrl(songUrls[index]);
      setState(() {
        currentSongIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.

    fetchBooks();
    // Combine streams to update UI accordingly
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery for responsive design
    double screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: AudioDrawer(songNames: songNames, changeSong: changeSong),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: screenWidth*1.2,
                        width: screenWidth * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            widget.book.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "تستمع الآن الى",
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                widget.book.title!,
                                style: const TextStyle(fontSize: 16),
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
              ),

              Directionality(
                  textDirection: TextDirection.ltr,
                  child: PlayerWidget(
                    player: player,
                    previousBook: previousBook,
                    nextBook: nextBook,
                  )),
              const SizedBox(
                  height: 20), // Adds some spacing at the very bottom
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;
  final Function previousBook;
  final Function nextBook;
  const PlayerWidget({
    required this.player,
    super.key,
    required this.previousBook,
    required this.nextBook,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get player => widget.player;

  @override
  void initState() {
    super.initState();
    // Use initial values from player
    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() {
            _duration = value;
          }),
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();
  }

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Slider(
          onChanged: (value) {
            final duration = _duration;
            if (duration == null) {
              return;
            }
            final position = value * duration.inMilliseconds;
            player.seek(Duration(milliseconds: position.round()));
          },
          value: (_position != null &&
                  _duration != null &&
                  _position!.inMilliseconds > 0 &&
                  _position!.inMilliseconds < _duration!.inMilliseconds)
              ? _position!.inMilliseconds / _duration!.inMilliseconds
              : 0.0,
        ),
        Text(
          _position != null
              ? '$_positionText / $_durationText'
              : _duration != null
                  ? _durationText
                  : '',
          style: const TextStyle(fontSize: 16.0),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => widget.previousBook(),
              icon: const Icon(Icons.skip_previous),
              iconSize: 48,
              color: color,
            ),
            IconButton(
              key: const Key('play_button'),
              onPressed: _isPlaying ? _pause : _play,
              iconSize: 48.0,
              icon: !_isPlaying
                  ? const Icon(Icons.play_arrow)
                  : const Icon(Icons.pause),
              color: color,
            ),
            IconButton(
              onPressed: () => widget.nextBook(),
              icon: const Icon(Icons.skip_next),
              iconSize: 48,
              color: color,
            ),
          ],
        ),
      ],
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }
}
