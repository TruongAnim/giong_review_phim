import 'package:flutter/material.dart';
import 'package:giongreviewphim/models/options.dart';

class Constants {
  static final List<Option> voice = [
    Option(text: 'Giọng miền bắc: Ban Mai (Nữ)', value: 'banmai'),
    Option(text: 'Giọng miền bắc: Lê Minh (Nam)', value: 'leminh'),
    Option(text: 'Giọng miền bắc: Thu Minh (Nữ)', value: 'thuminh'),
    Option(text: 'Giọng miền trung: Mỹ An (Nữ)', value: 'myan'),
    Option(text: 'Giọng miền trung: Ngọc Lam (Nữ)', value: 'ngoclam'),
    Option(text: 'Giọng miền trung: Gia Huy (Nam)', value: 'giahuy'),
    Option(text: 'Giọng miền nam: Lan Nhi (Nữ)', value: 'lannhi'),
    Option(text: 'Giọng miền nam: Linh San (Nữ)', value: 'linhsan'),
    Option(text: 'Giọng miền nam: Minh Quang (Nam)', value: 'minhquang'),
  ];
  static final List<Option> speed = [
    Option(text: 'Bình thường', value: '0'),
    Option(text: 'Rất chậm', value: '-3'),
    Option(text: 'Chậm', value: '-2'),
    Option(text: 'Hơi chậm', value: '-1'),
    Option(text: 'Hơi nhanh', value: '1'),
    Option(text: 'Nhanh', value: '2'),
    Option(text: 'Rất nhanh', value: '3'),
  ];

  static const String apiKey = '6QM7JU6XWxx2WVnxB5VHEw7ESGgj3RUZ';
  static const String apiUrl = 'https://api.fpt.ai/hmi/tts/v5';
  static const int maxLength = 150;
}

const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF25254B);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;
