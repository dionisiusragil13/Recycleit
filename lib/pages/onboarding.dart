import 'package:flutter/material.dart';
import 'package:recyleit/services/widget_support.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Image.asset("images/onboard.png"),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Recycle Your Wasted Products!",
                style: AppWidget.headlinetextstyle(34.0),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Easily collect household waste and generate less waste",
                style: AppWidget.normaltextstyle(18.0),
              ),
            ),
            SizedBox(height: 90,),
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width/1.5,
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: AppWidget.whitetextstyle(24.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
