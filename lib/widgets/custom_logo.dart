import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomLogo extends StatelessWidget {
  double distance;
  CustomLogo({@required this.distance});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: height * distance, right: 15.0, left: 15.0),
      child: Container(
        height: height > 360.0 ? height * 0.27 : height * 0.45,
        child: Stack(
          children: <Widget>[
            Image(
              image: AssetImage('images/icons/shop.png'),
              width: 150.0,
              height: 150.0,
            ),
            Positioned(
              bottom: 0,
              left: 20,
              child: Text(
                'Proceed with your',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
