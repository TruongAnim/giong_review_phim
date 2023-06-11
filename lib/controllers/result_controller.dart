import 'package:get/get.dart';
import 'package:giongreviewphim/models/convert_job.dart';
import 'package:giongreviewphim/services/download_service.dart';

class ResultController extends GetxController {
  final DownloadService _service = DownloadService.instance;
  late ConvertJob _job;
  void setJob(ConvertJob job) {
    _job = job;
  }

  ConvertJob get job => _job;

  Future<String> download(String url) async {
    return _service.downloadFile(url);
  }
}
