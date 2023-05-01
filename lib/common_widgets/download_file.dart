import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/components/animated_btn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';

class DownloadScreen extends StatefulWidget {
  final String url;

  DownloadScreen({Key? key, required this.url}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  late RiveAnimationController _btnAnimationColtroller;
  String _localPath = '';
  late bool _downloading;
  late String _downloadMessage;

  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
      // Let's restart the app again
      // No amination
    );
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
      child: AnimatedBtn(
        text: 'Download',
        icon: !_downloading
            ? const Icon(
                Icons.download,
                color: Colors.white,
              )
            : const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
        btnAnimationColtroller: _btnAnimationColtroller,
        press: () async {
          _btnAnimationColtroller.isActive = true;
          await Future.delayed(const Duration(milliseconds: 800));
          await _downloadFile(widget.url);
          Get.showSnackbar(GetSnackBar(
            title: _downloadMessage.startsWith('Error') ? 'Error!' : 'Success!',
            message: _downloadMessage,
            duration: const Duration(seconds: 2),
          ));
        },
      ),
    );
  }
}
