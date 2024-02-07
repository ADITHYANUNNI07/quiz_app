import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quiz_app/db/database.dart';
import 'package:quiz_app/screen/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initalizeHiveandAdapter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          primarySwatch: customPrimaryColor,
          primaryColor: const Color(0XFF4fa1ca),
          focusColor: const Color(0XFF4fa1ca)),
      debugShowCheckedModeBanner: false,
      home: const SplashScrn(),
    );
  }
}

const MaterialColor customPrimaryColor = MaterialColor(0XFF4fa1ca, <int, Color>{
  50: Color(0XFF4fa1ca),
  100: Color(0XFF4fa1ca),
  200: Color(0XFF4fa1ca),
  300: Color(0XFF4fa1ca),
  400: Color(0XFF4fa1ca),
  500: Color(0XFF4fa1ca),
  600: Color(0XFF4fa1ca),
  700: Color(0XFF4fa1ca),
  800: Color(0XFF4fa1ca),
  900: Color(0XFF4fa1ca),
});
