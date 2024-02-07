import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/screen/welcome/welcome.dart';

class SplashScrn extends StatefulWidget {
  const SplashScrn({super.key});

  @override
  State<SplashScrn> createState() => _SplashScrnState();
}

bool issignedIn = false;
String email = '';

class _SplashScrnState extends State<SplashScrn> {
  @override
  void initState() {
    splashtime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF4fa1ca),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
                'assets/animation/Animation - 1706342375691.json'),
            Text("QUIZ APP",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color(0XFFE0E0E0),
                  fontSize: 38,
                ))
          ],
        ),
      ),
    );
  }

  void splashtime() async {
    Future.delayed(
      const Duration(seconds: 4),
      () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const WelcomeScrn(),
          ),
        );
      },
    );
  }
}
