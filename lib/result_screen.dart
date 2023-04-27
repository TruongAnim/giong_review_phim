import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Map<String, dynamic> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(data['url']),
    );
  }
}
