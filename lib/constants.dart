import 'package:flutter/material.dart';
import 'package:giongreviewphim/models/options.dart';

class Constants {
  static List<Option> voice = [
    Option(text: 'Ban Mai', value: 'banmai'),
    Option(text: 'Thu Minh', value: 'thuminh'),
    Option(text: 'Mỹ An', value: 'myan'),
    Option(text: 'Gia Huy', value: 'giahuy'),
  ];
  static List<Option> speed = [
    Option(text: 'Rất chậm', value: '-3'),
    Option(text: 'Chậm', value: '-2'),
    Option(text: 'Hơi chậm', value: '-1'),
    Option(text: 'Bình thường', value: '0'),
    Option(text: 'Hơi nhanh', value: '1'),
    Option(text: 'Nhanh', value: '2'),
    Option(text: 'Rất nhanh', value: '3'),
  ];
}

const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF25254B);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;
