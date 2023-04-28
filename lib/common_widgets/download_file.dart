import 'dart:io';
import 'dart:ui';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DownloadFileWidget extends StatefulWidget {
  final String url;

  const DownloadFileWidget({Key? key, required this.url}) : super(key: key);

  @override
  _DownloadFileWidgetState createState() => _DownloadFileWidgetState();
}

class _DownloadFileWidgetState extends State<DownloadFileWidget> {
  String _localFilePath = '';
  late bool _isDownloading;
  late String _taskId;

  @override
  void initState() {
    super.initState();
    _isDownloading = false;
  }

  Future<String> _getDownloadPath() async {
    final directory = await getExternalStorageDirectory();
    return directory!.path + '/Download';
  }

  void _startDownload() async {
    final downloadPath = await _getDownloadPath();
    final fileName = widget.url.split('/').last;
    final savedDir = Directory(downloadPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isDownloading = true;
    });

    _taskId = (await FlutterDownloader.enqueue(
      url: widget.url,
      savedDir: downloadPath,
      fileName: fileName,
      showNotification: false,
      openFileFromNotification: false,
    ))!;
    print('task id: ${_taskId}');
    FlutterDownloader.registerCallback(downloadCallback, step: 1);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    print(
      'Callback on background isolate: '
      'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }

  void _cancelDownload() async {
    await FlutterDownloader.cancel(taskId: _taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isDownloading)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text('Downloading...'),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _cancelDownload,
                child: Text('Cancel'),
              ),
            ],
          ),
        if (!_isDownloading && _localFilePath.isEmpty)
          ElevatedButton(
            onPressed: _startDownload,
            child: Text('Download'),
          ),
        if (!_isDownloading && _localFilePath.isNotEmpty)
          ElevatedButton(
            onPressed: () {
              // Open downloaded file
              final file = File(_localFilePath);
              print(file.uri);
              file.exists().then((exists) {
                if (exists) {
                  OpenFile.open(file.path);
                }
              });
            },
            child: Text('Open file'),
          ),
      ],
    );
  }
}

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
