import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:raia_rgon/consestsnt.dart';
import 'package:raia_rgon/provider/modal_hud.dart';
import 'package:raia_rgon/screens/login_screen.dart';
import 'package:raia_rgon/services/auth.dart';
import 'package:raia_rgon/widgets/custom_logo.dart';
import 'package:raia_rgon/widgets/custom_textfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'user/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  static String id = 'SignUpScreen';
  String _email, _password, _name;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Auth _auth = new Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: ListView(
          children: <Widget>[
            CustomLogo(distance: 0.03),
            Padding(
              padding: EdgeInsets.only(top: 5.0, right: 35.0, left: 35.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    CustomTextField(
                      label: 'User Name',
                      icon: Icons.person_outline,
                      onclick: (String value) {
                        _name = value;
                      },
                    ),
                    CustomTextField(
                      label: 'Email',
                      icon: Icons.email,
                      onclick: (String value) {
                        _email = value;
                      },
                    ),
                    CustomTextField(
                      label: 'Password',
                      icon: Icons.lock_outline,
                      onclick: (String value) {
                        _password = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.0, right: 35.0, top: 10.0),
              child: Builder(
                builder: (context) => FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0),
                  )),
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  color: KmainColor,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    final ModalHud modalHud = Provider.of<ModalHud>(context, listen: false);
                    if (_globalKey.currentState.validate()) {
                      modalHud.isLoadingChange(true);
                      try {
                        _globalKey.currentState.save();
                        final AuthResult authResult =
                            await _auth.signUp(_email, _password);
                        modalHud.isLoadingChange(false);
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      } on PlatformException catch (exception) {
                        modalHud.isLoadingChange(false);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.grey.shade700,
                          content: Text(
                            exception.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
                          ),
                        ));
                      }
                    }
                    modalHud.isLoadingChange(false);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Do you have an account ?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    )),
                    color: KmainColor,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
