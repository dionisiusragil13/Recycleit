import 'package:flutter/material.dart';
import 'package:recyleit/services/auth.dart';
import 'package:recyleit/services/widget_support.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "images/login.png",
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.0),
            Image.asset("images/recycle1.png", height: 120, width: 120),
            SizedBox(height: 20.0),
            Text(
              "Reduce. Reuse. Recycle.",
              style: AppWidget.headlinetextstyle(25.0),
            ),
            Text("Repeat!", style: AppWidget.greentextstyle(30)),
            SizedBox(height: 80.0),
            Text(
              "Every item you recycle\nmakes a difference!",
              textAlign: TextAlign.center,
              style: AppWidget.normaltextstyle(18.0),
            ),
            Text("Get Started!", style: AppWidget.greentextstyle(25.0)),
            SizedBox(height: 30.0),
            GestureDetector(
              onTap: () {
                AuthMethods().signInWithGoogle(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 80,
                    padding: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Image.asset(
                            "images/google.png",
                            height: 50,
                            width: 50,
                          ),
                        ),
                        SizedBox(width: 30.0),
                        Text(
                          "Sign in with google",
                          style: AppWidget.whitetextstyle(25.0),
                        ),
                      ],
                    ),
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
