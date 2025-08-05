import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sampark_app/config/page_path.dart';
import 'package:sampark_app/config/themes.dart';
import 'package:sampark_app/controller/call_controller.dart';
import 'package:sampark_app/firebase_options.dart';
import 'package:sampark_app/pages/Auth/auth_page.dart';
import 'package:sampark_app/pages/SplashPage/splash_page.dart';
import 'package:sampark_app/pages/homePage/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://jdxvzfndgcckrhomyiux.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpkeHZ6Zm5kZ2Nja3Job215aXV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI0Mjg2ODEsImV4cCI6MjA2ODAwNDY4MX0.yThd-Onmwqt-gnC2wCeIuXiRj9S-FexQXEeBJ9k3BuM',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: FToastBuilder(),
      title: 'Sampark',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      getPages: pagePath,
      home: SplashPage(),
    );
  }
}
