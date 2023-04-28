import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;

  const AudioPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  Duration _duration = Duration();
  Duration _position = Duration();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _play() async {
    await _audioPlayer.play(UrlSource(widget.url));
  }

  void test(AudioCache cache) async {
    String dir = await cache.getTempDir();
    String uri = await cache.prefix;
    print(dir);
    print(uri);
    print(cache.loadedFiles);
    print("load oke");
  }

  void _pause() async {
    await _audioPlayer.pause();
  }

  void _seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${_position.inSeconds} / ${_duration.inSeconds} seconds'),
        Slider(
          value: _position.inSeconds.toDouble(),
          min: 0,
          max: _duration.inSeconds.toDouble(),
          onChanged: (double value) {
            _seekTo(Duration(seconds: value.toInt()));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: _isPlaying ? null : _play,
            ),
            IconButton(
              icon: Icon(Icons.pause),
              onPressed: _isPlaying ? _pause : null,
            ),
          ],
        ),
      ],
    );
  }
}
