import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackcam/services/theme_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trackcam/views/home_screen.dart';
import 'package:trackcam/views/login_screen.dart';

import 'misc/constants.dart';
import 'misc/messages.dart';

void main() async{
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      translations: Messages(), // your translations
      locale: ThemeServices().loadLocale(),
      fallbackLocale: Locale('en', 'US'),
      theme: ThemeData(
        secondaryHeaderColor: Colors.blueGrey,
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black54,
          displayColor: Colors.black54,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.grey,
        secondaryHeaderColor: Colors.blueGrey,
        brightness: Brightness.dark,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white54,

        ),
      ),
      themeMode: ThemeServices().theme,
      home: HomeScreen(),
    );
  }
}

