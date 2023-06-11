import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/constants.dart';
import 'package:giongreviewphim/models/convert_job.dart';
import 'package:giongreviewphim/utils.dart';

class AudioPlayerWidget extends StatefulWidget {
  final ConvertJob job;

  const AudioPlayerWidget({Key? key, required this.job}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  Duration _duration = const Duration(seconds: 1);
  Duration _position = const Duration();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setSource(UrlSource(widget.job.url));
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
    await _audioPlayer.play(UrlSource(widget.job.url));
  }

  void _pause() async {
    await _audioPlayer.pause();
  }

  void _seekTo(Duration position) async {
    await _audioPlayer.seek(position);
    if (_audioPlayer.state == PlayerState.completed) {
      _play();
    }
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
                SizedBox(
                  width: 100, // set the width of the SizedBox
                  height: 100,
                  child: CircularProgressIndicator(
                    value: _position.inMilliseconds / _duration.inMilliseconds,
                    backgroundColor: Colors.grey[300],
                    strokeWidth: 6, // adjust the thickness of the ring

                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            Constants.voice[widget.job.voice].getText(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87),
          ),
        ),
        Text(
          '${"speed".tr} ${Constants.speed[widget.job.speed].getText()}',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "0:00",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              child: Slider(
                value: _position.inMilliseconds.toDouble(),
                min: 0,
                max: _duration.inMilliseconds.toDouble(),
                onChanged: (value) {
                  _seekTo(Duration(milliseconds: value.toInt()));
                },
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
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
  }
}
