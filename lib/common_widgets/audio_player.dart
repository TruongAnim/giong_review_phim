import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:giongreviewphim/utils.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;

  const AudioPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setSource(UrlSource(widget.url));
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
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.release();
    super.dispose();
  }

  void _play() async {
    await _audioPlayer.play(UrlSource(widget.url));
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
      children: [
        Expanded(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: _position.inSeconds / _duration.inSeconds,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                IconButton(
                  iconSize: 64,
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    if (_isPlaying) {
                      _pause();
                    } else {
                      _play();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            "Song Title",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Text(
          "Artist Name",
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "0:00",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              child: Slider(
                value: _position.inSeconds.toDouble(),
                min: 0,
                max: _duration.inSeconds.toDouble(),
                onChanged: (value) {
                  _seekTo(Duration(seconds: value.toInt()));
                },
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[300],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                Utils.durationToString(_duration),
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ],
    );

    Column(
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
              icon: const Icon(Icons.play_arrow),
              onPressed: _isPlaying ? null : _play,
            ),
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: _isPlaying ? _pause : null,
            ),
          ],
        ),
      ],
    );
  }
}
