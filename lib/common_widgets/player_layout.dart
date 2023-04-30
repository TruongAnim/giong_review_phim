import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AudioPlayerLayout extends StatefulWidget {
  @override
  _AudioPlayerLayoutState createState() => _AudioPlayerLayoutState();
}

class _AudioPlayerLayoutState extends State<AudioPlayerLayout> {
  bool isPlaying = false;
  double playbackProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Player"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: playbackProgress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  IconButton(
                    iconSize: 64,
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                      });
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
                  value: playbackProgress,
                  onChanged: (value) {
                    setState(() {
                      playbackProgress = value;
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey[300],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Text(
                  "2:30",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
