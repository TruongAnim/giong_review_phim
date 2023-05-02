import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/page_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      getPages: PageRouter.listPage,
      initialRoute: PageRouter.contentScreen,
    );
  }
}
