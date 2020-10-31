import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:raia_rgon/models/product.dart';
import 'package:raia_rgon/services/store.dart';
import 'package:raia_rgon/widgets/custom_textfield.dart';
import '../../consestsnt.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Store _store = new Store();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 30.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: KmainColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 35.0,
                  right: 35.0,
                  top: height * 0.08,
                  bottom: height * 0.04,
                ),
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
                        height: height * 0.02,
                      ),
                      RaisedButton(
                        color: KmainColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 25.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          ),
                        ),
                        child: Text(
                          'Edit Product',
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
                            _store.editProduct({
                              KProductName: _name,
                              KProductPrice: _price,
                              KProductDescription: _description,
                              KProductCategory: _category,
                              KProductImageLocation: _imageLocation,
                            }, product.pId);
                          }
                        },
                      ),
                    ],
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
