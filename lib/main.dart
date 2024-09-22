import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:state_management/API/Header_Passing/header_screen.dart';
import 'package:state_management/Movie_App/screens/splash_screen.dart';
import 'package:state_management/Shared_Preferences/save_data.dart';

import 'package:state_management/State_Management/counter_controller.dart';

void main() {
  runApp(MycounterAPP());
}

class MycounterAPP extends StatelessWidget {
  MycounterAPP({super.key});

  //dependency injection

  final dependency = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieDB',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        fontFamily: GoogleFonts.ptSans().fontFamily,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(surface: Colors.white),
      ),

      home: const SplashScreen(),


    );
  }
}
