import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raia_rgon/consestsnt.dart';
import 'package:raia_rgon/screens/admin/manage_product.dart';
import 'add_product.dart';
import 'orders_screen.dart';

class AdminScreen extends StatelessWidget {
  static String id = 'AdminScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 5.0),
//            child: RaisedButton(
//                color: KmainColor,
//                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(35.0),
//                      bottomRight: Radius.circular(25.0)
//                  ),
//                ),
//                child: Text('Add Product', style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.bold,
//                  letterSpacing: 0.5,
//                ),),
//                onPressed: (){
//                  Navigator.pushNamed(context, AddProduct.id);
//                }
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 5.0),
//            child: RaisedButton(
//              color: KmainColor,
//              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.only(
//                    bottomLeft: Radius.circular(25.0),
//                    topRight: Radius.circular(35.0)
//                ),
//              ),
//              child: Text('Edit Product', style: TextStyle(
//                color: Colors.white,
//                fontSize: 18.0,
//                fontWeight: FontWeight.bold,
//                letterSpacing: 0.5,
//              ),),
//              onPressed: (){
//                Navigator.pushNamed(context, EditProduct.id);
//              },
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 5.0),
//            child: RaisedButton(
//                color: KmainColor,
//                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(35.0),
//                      bottomRight: Radius.circular(25.0)
//                  ),
//                ),
//                child: Text('View Orders', style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.bold,
//                  letterSpacing: 0.5,
//                ),),
//                onPressed: (){}
//            ),
//          ),
          customButton(
              title: 'Add Product',
              border: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(25.0)),
              ),
              onClick: () {
                Navigator.pushNamed(context, AddProduct.id);
              }),
          customButton(
              title: 'Edit Product',
              border: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    topRight: Radius.circular(35.0)),
              ),
              onClick: () {
                Navigator.pushNamed(context, ManageProduct.id);
              }),
          customButton(
              title: 'View Orders',
              border: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(25.0)),
              ),
              onClick: () {
                Navigator.pushNamed(context, OrdersScreen.id);
              },),
        ],
      ),
    );
  }

  Widget customButton({ShapeBorder border, String title, Function onClick}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: RaisedButton(
          color: KmainColor,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          shape: border,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          onPressed: () {
            onClick();
          }),
    );
  }
}
