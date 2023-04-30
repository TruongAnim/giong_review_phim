import 'package:get/get.dart';
import 'package:giongreviewphim/models/convert_job.dart';

class ResultController extends GetxController {
  late ConvertJob _job;
  void setJob(ConvertJob job) {
    _job = job;
  }

  ConvertJob get job => _job;
}
