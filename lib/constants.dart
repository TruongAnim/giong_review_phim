import 'package:flutter/material.dart';
import 'package:giongreviewphim/models/options.dart';

class Constants {
  static final List<Option> voice = [
    Option(text: "bm", value: 'banmai'),
    Option(text: "lm", value: 'leminh'),
    Option(text: "tm", value: 'thuminh'),
    Option(text: "ma", value: 'myan'),
    Option(text: "nl", value: 'ngoclam'),
    Option(text: "gh", value: 'giahuy'),
    Option(text: "ln", value: 'lannhi'),
    Option(text: "ls", value: 'linhsan'),
    Option(text: "mq", value: 'minhquang'),
  ];
  static final List<Option> speed = [
    Option(text: "normal", value: '0'),
    Option(text: "very-slow", value: '-3'),
    Option(text: "slow", value: '-2'),
    Option(text: "quite-slow", value: '-1'),
    Option(text: "quite-fast", value: '1'),
    Option(text: "fast", value: '2'),
    Option(text: "very-fast", value: '3'),
  ];

  static const String apiUrl = 'https://api.fpt.ai/hmi/tts/v5';
  static const int maxLength = 2500;

  static const String langPath = 'assets/lang/';
}

const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF25254B);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;
