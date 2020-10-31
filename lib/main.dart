import 'package:flutter/material.dart';
import 'package:raia_rgon/consestsnt.dart';
import 'package:raia_rgon/provider/admin_mode.dart';
import 'package:raia_rgon/provider/cart_item.dart';
import 'package:raia_rgon/provider/modal_hud.dart';
import 'package:raia_rgon/screens/admin/add_product.dart';
import 'package:raia_rgon/screens/admin/admin_screen.dart';
import 'package:raia_rgon/screens/admin/edit_product.dart';
import 'package:raia_rgon/screens/admin/manage_product.dart';
import 'package:raia_rgon/screens/admin/order_details.dart';
import 'package:raia_rgon/screens/user/favourite_screen.dart';
import 'package:raia_rgon/screens/user/home_screen.dart';
import 'package:raia_rgon/screens/splash_screen.dart';
import 'package:raia_rgon/screens/login_screen.dart';
import 'package:raia_rgon/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'provider/favourite_product.dart';
import 'screens/admin/orders_screen.dart';
import 'screens/user/cart_screen.dart';
import 'screens/user/product_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(
          create: (context) => ModalHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
        ChangeNotifierProvider<FavouriteProduct>(
          create: (context) => FavouriteProduct(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          buttonTheme: ButtonThemeData(minWidth: 5),
          accentColor: KmainColor,
          primaryColor: KmainColor,
        ),
        title: 'E-Shopping',
        initialRoute: SplashScreen.id,
        routes: <String, WidgetBuilder>{
          SplashScreen.id: (context) => SplashScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          AdminScreen.id: (context) => AdminScreen(),
          AddProduct.id: (context) => AddProduct(),
          ManageProduct.id: (context) => ManageProduct(),
          EditProduct.id: (context) => EditProduct(),
          ProductInfo.id: (context) => ProductInfo(),
          CartScreen.id: (context) => CartScreen(),
          FavouriteScreen.id: (context) => FavouriteScreen(),
          OrdersScreen.id: (context) => OrdersScreen(),
          OrderDetails.id: (context) => OrderDetails(),
        },
      ),
    );
  }
}
