import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurants_bars/Routes/app_pages.dart';

import 'Routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      title: 'Flutter Demo',
      getPages: AppPages.routes,
      initialRoute: Routes.INITIAL,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}