// lib/view/splash_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view_model/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sử dụng SplashViewMode
    final splashVM = Get.find<SplashViewMode>();

    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed('/login'); // Điều hướng đến LoginPage
    });

    return Scaffold(
      body: Center(
        child: Image.asset('assets/img/splah_view.jpg'), // Hiển thị ảnh splash
      ),
    );
  }
}
