import 'package:giongreviewphim/models/options.dart';

class Constants {
  static List<Option> voice = [
    Option(text: 'Ban Mai', value: 'banmai'),
    Option(text: 'Thu Minh', value: 'thuminh'),
    Option(text: 'Mỹ An', value: 'myan'),
    Option(text: 'Gia Huy', value: 'giahuy'),
  ];
  static List<Option> speed = [
    Option(text: 'Chậm -3', value: '-3'),
    Option(text: '-2', value: '-2'),
    Option(text: '-1', value: '-1'),
    Option(text: 'Bình thường 0', value: '0'),
    Option(text: '1', value: '1'),
    Option(text: '2', value: '2'),
    Option(text: 'Nhanh 3', value: '3'),
  ];
}
