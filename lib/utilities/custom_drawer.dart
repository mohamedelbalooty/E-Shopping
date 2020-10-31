import 'package:flutter/material.dart';
import 'package:raia_rgon/screens/login_screen.dart';
import 'package:raia_rgon/screens/user/favourite_screen.dart';
import 'package:raia_rgon/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../consestsnt.dart';

class CustomDrawer extends StatelessWidget {
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: KmainColor,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.02,
                ),
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
                      radius: 40.0,
                      backgroundColor: Colors.white,
                      child: Image(
                        image: AssetImage('images/icons/shop.png'),
                      ),
                    ),
                  ),
                ),
                Text(
                  'E-Shopping',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18.0, letterSpacing: 1.0),
                ),
              ],
            ),
          ),
          // TODO CUSTOM WIDGET
          ListTile(
            title: Text('Favourite products'),
            trailing: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, FavouriteScreen.id);
              },
            ),
          ),
          ListTile(
            title: Text('Sign Out'),
            trailing: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
                color: Colors.black,
              ),
              onPressed: () {
                onClick(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  onClick(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    await _auth.signOut();
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }
}
