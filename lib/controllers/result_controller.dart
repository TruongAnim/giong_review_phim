import 'package:get/get.dart';
import 'package:giongreviewphim/models/convert_job.dart';

class ResultController extends GetxController {
  late ConvertJob _job;
  void setJob(ConvertJob job) {
    _job = job;
  }

  String get url => _job.url;
  String get speed => _job.speed;
  String get voice => _job.voice;
}
