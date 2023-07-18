import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/page_router.dart';
import 'package:giongreviewphim/services/translations_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final translationService = TranslationService();
  await Firebase.initializeApp();
  await translationService.init();
  runApp(MyApp(
    translationService: translationService,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.translationService});
  final TranslationService translationService;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      translations: translationService,
      locale: window.locale,
      fallbackLocale: const Locale('en'),
      getPages: PageRouter.listPage,
      initialRoute: PageRouter.contentScreen,
      debugShowCheckedModeBanner: false,
    );
  }
}
