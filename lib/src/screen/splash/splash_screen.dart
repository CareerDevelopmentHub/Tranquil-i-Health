// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HandleOnBoarding extends StatelessWidget {
  const HandleOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(
              height: 450,
              child: Center(
                child: RiveAnimation.asset('assets/images/loading.riv'),
              ),
            ),
            SizedBox(
              child: Text(
                'Tranquil-i-Health',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
