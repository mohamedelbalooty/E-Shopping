import 'package:flutter/material.dart';
import 'package:raia_rgon/consestsnt.dart';

class CustomTextField extends StatelessWidget {
  String label;
  IconData icon;
  Function onclick;

  CustomTextField({
    @required this.label,
    @required this.onclick,
    @required this.icon,
  });

  String _errorMessage(String errorValue) {
    switch (label) {
      case 'User Name':
        return 'Enter your name';
        break;
      case 'Email':
        return 'Enter your email';
        break;
      case 'Password':
        return 'Enter your password';
        break;
      case 'Product Name':
        return 'Enter your product name';
        break;
      case 'Product Price':
        return 'Enter your product price';
        break;
      case 'Product Description':
        return 'Enter your product description';
        break;
      case 'Product Category':
        return 'Enter your product category';
        break;
      case 'Product Image Location':
        return 'Enter your image product location';
        break;
      default:
        return 'Enter your info';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.018),
      child: TextFormField(
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(label);
          }
        },
        onSaved: onclick,
        cursorColor: KmainColor,
        obscureText: label == 'Password' ? true : false,
        style: TextStyle(
          color: Colors.grey.shade700,
        ),
        decoration: InputDecoration(
          suffixIcon: Icon(
            icon,
            color: KsecondColor,
          ),
          labelText: label,
          helperMaxLines: 1,
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: KsecondColor,
              width: 2.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: KsecondColor,
              width: 2.0,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: KsecondColor,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: KsecondColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
