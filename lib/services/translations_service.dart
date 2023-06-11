import 'package:get/get.dart';
import 'package:giongreviewphim/constants.dart';
import 'package:giongreviewphim/utils/json_utils.dart';

class TranslationService extends Translations {
  final JsonUtils _jsonUtils = JsonUtils.instance;

  static const List<String> supportLangs = ['en', 'vi'];
  final Map<String, dynamic> _localizedStrings = {};
  Future<void> init() async {
    for (String item in supportLangs) {
      _localizedStrings[item] =
          await _jsonUtils.loadJsonFile('${Constants.langPath}$item.json');
    }
  }

  @override
  Map<String, Map<String, String>> get keys =>
      {for (var item in supportLangs) item: _localizedStrings[item]};
}
