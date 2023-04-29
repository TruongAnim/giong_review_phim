import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DownloadScreen extends StatefulWidget {
  final String url;

  DownloadScreen({Key? key, required this.url}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  String _localPath = '';
  late bool _downloading;
  late String _downloadMessage;

  @override
  void initState() {
    super.initState();
    _downloading = false;
    _downloadMessage = '';
    _getLocalPath();
  }

  Future<void> _getLocalPath() async {
    final directory = await _getSavedDir();
    if (directory != null) {
      setState(() {
        _localPath = directory;
        print(_localPath);
      });
    } else {
      setState(() {
        _downloadMessage = 'Unable to access external storage';
      });
    }
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        print('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<void> _downloadFile(String url) async {
    setState(() {
      _downloading = true;
      _downloadMessage = 'Downloading file...';
    });
    try {
      final response = await http.get(Uri.parse(url));
      final filename = Uri.parse(url).pathSegments.last;
      final path = '$_localPath/$filename';
      final file = File(path);
      await file.writeAsBytes(response.bodyBytes);
      setState(() {
        _downloading = false;
        _downloadMessage = 'File saved to $_localPath';
      });
    } catch (e) {
      setState(() {
        _downloading = false;
        _downloadMessage = 'Error downloading file: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_localPath == null)
            Text(_downloadMessage)
          else if (_downloading)
            CircularProgressIndicator()
          else
            Text(_downloadMessage),
          IconButton(
              onPressed:
                  _localPath == null ? null : () => _downloadFile(widget.url),
              icon: Icon(Icons.file_download))
        ],
      ),
    );
  }
}
