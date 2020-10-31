import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:raia_rgon/consestsnt.dart';
import 'package:raia_rgon/provider/admin_mode.dart';
import 'package:raia_rgon/provider/modal_hud.dart';
import 'package:raia_rgon/widgets/custom_logo.dart';
import 'signup_screen.dart';
import 'admin/admin_screen.dart';
import 'user/home_screen.dart';
import 'package:raia_rgon/services/auth.dart';
import 'package:raia_rgon/widgets/custom_textfield.dart';


class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String _email, _password;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Auth _auth = new Auth();
  final String adminPassword = 'admin123456789';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: ListView(
          children: <Widget>[
            CustomLogo(distance: 0.05),
            Padding(
              padding: EdgeInsets.only(top: 8.0, right: 35.0, left: 35.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.07,
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
                    'Login',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    _validate(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.0, right: 35.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account... ?',
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
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          color: Provider.of<AdminMode>(context).mode
                              ? Colors.white
                              : KmainColor,
                          child: Text(
                            'I\'m an admin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Provider.of<AdminMode>(context, listen: false)
                                .modeChange(true);
                          },
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          color: Provider.of<AdminMode>(context).mode
                              ? KmainColor
                              : Colors.white,
                          child: Text(
                            'I\'m a user',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Provider.of<AdminMode>(context, listen: false)
                                .modeChange(false);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final ModalHud modalHud = Provider.of<ModalHud>(context, listen: false);
    modalHud.isLoadingChange(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).mode) {
        if(_password == adminPassword){
          try {
            final AuthResult authResult = await _auth.logIn(_email, _password);
            modalHud.isLoadingChange(false);
            Navigator.pushReplacementNamed(context, AdminScreen.id);
          } on PlatformException catch (exception) {
            modalHud.isLoadingChange(false);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.grey.shade700,
                content: Text(
                  exception.message,
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5,),
                ),
              ),
            );
          }
        }else{
          modalHud.isLoadingChange(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.grey.shade700,
            content: Text(
              'Something went wrong',
              textAlign: TextAlign.center,
              style:
              TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5,),
            ),
          ),);
        }
      } else {
        try {
          final AuthResult authResult = await _auth.logIn(_email, _password);
          modalHud.isLoadingChange(false);
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        } on PlatformException catch (exception) {
          modalHud.isLoadingChange(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.grey.shade700,
              content: Text(
                exception.message,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5,),
              ),
            ),
          );
        }
      }
    }
    modalHud.isLoadingChange(false);
  }
}
