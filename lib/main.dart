import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/page_manager.dart';
import 'package:music_player/audio_helpers/service_locator.dart';
import 'package:music_player/common/color_extension.dart';
import 'package:music_player/screens/login_page.dart'; // Import LoginPage
import 'package:music_player/screens/register_page.dart'; // Import RegisterPage
import 'package:music_player/view/main_tabview/main_tabview.dart'; // Import MainTabView
import 'package:music_player/view/splash_view.dart';
import 'package:music_player/view_model/splash_view_model.dart'; // Import SplashViewMode

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDs34BZeuQPBhDMCcRKzQHWhPgpvkF7GJU",
            appId: "1:129967075380:web:6bfb2d2ffb90e1da965a61",
            messagingSenderId: "129967075380",
            projectId: "music-yersin"));
  } else {
    await Firebase.initializeApp();
  }
  await setupServiceLocator();

  // Initialize SplashViewMode
  Get.put(SplashViewMode());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App nghe nhạc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Circular Std",
        scaffoldBackgroundColor: TColor.bg,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: TColor.primary,
        ),
        useMaterial3: false,
      ),
      home: const SplashView(), // Hiển thị SplashView trước
      getPages: [
        GetPage(name: '/', page: () => const SplashView()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/home', page: () => const MainTabView()), // Thêm MainTabView
      ],
    );
  }
}
