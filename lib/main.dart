import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/views.dart/content_screen.dart';
import 'package:giongreviewphim/page_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const _title = 'flutter_downloader demo';

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    return GetMaterialApp(
      title: _title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      getPages: PageRouter.listPage,
      initialRoute: PageRouter.contentScreen,
    );
  }
}
