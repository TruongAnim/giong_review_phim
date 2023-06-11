import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class DownloadService {
  DownloadService._();
  static final DownloadService _instance = DownloadService._();
  static DownloadService get instance => _instance;
  final Dio _dio = Dio();

  Future<String> downloadFile(String url) async {
    try {
      if (await Permission.storage.request().isGranted) {
        var savePath = '/storage/emulated/0/Download';
        savePath += '/${path.basename(url)}';
        await _dio.download(url, savePath,
            onReceiveProgress: (received, total) {
          // if (total != -1) {
          //   double progress = (received / total * 100);
          // }
        });
        return 'Success!!!:File downloaded to $savePath';
      } else {
        return 'Error!!!:Permission to access storage denied. Downloading requires storage permission.';
      }
    } catch (e) {
      return 'Error!!!:$e';
    }
  }
}
