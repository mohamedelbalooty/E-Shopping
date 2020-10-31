import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raia_rgon/consestsnt.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KmainColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(
                height: height * 0.35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 60.0,
                            color: Colors.white70,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: Image(
                          image: AssetImage('images/icons/shop.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.1),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'E-SHOPPING',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'A new world of grocery shopping',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
