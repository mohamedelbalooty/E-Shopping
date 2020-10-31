import 'package:flutter/material.dart';
import 'package:raia_rgon/models/product.dart';
import 'package:raia_rgon/services/store.dart';
import 'package:raia_rgon/widgets/custom_textfield.dart';
import '../../consestsnt.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Store _store = new Store();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                left: 35.0,
                right: 35.0,
                top: height * 0.2,
                bottom: height * 0.1,),
            child: Form(
              key: _globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomTextField(
                    label: 'Product Name',
                    icon: Icons.portrait,
                    onclick: (String value) {
                      _name = value;
                    },
                  ),
                  CustomTextField(
                    label: 'Product Price',
                    icon: Icons.monetization_on,
                    onclick: (String value) {
                      _price = value;
                    },
                  ),
                  CustomTextField(
                    label: 'Product Description',
                    icon: Icons.receipt,
                    onclick: (String value) {
                      _description = value;
                    },
                  ),
                  CustomTextField(
                    label: 'Product Category',
                    icon: Icons.local_grocery_store,
                    onclick: (String value) {
                      _category = value;
                    },
                  ),
                  CustomTextField(
                    label: 'Product Image Location',
                    icon: Icons.image,
                    onclick: (String value) {
                      _imageLocation = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  RaisedButton(
                      color: KmainColor,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 25.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0)),
                      ),
                      child: Text(
                        'Add Product',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      onPressed: () {
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          _store.addProduct(
                            Product(
                              pName: _name,
                              pPrice: _price,
                              pDescription: _description,
                              pCategory: _category,
                              pImageLocation: _imageLocation,
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
