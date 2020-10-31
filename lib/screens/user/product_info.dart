import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:raia_rgon/consestsnt.dart';
import 'package:raia_rgon/models/product.dart';
import 'package:raia_rgon/provider/cart_item.dart';
import 'package:raia_rgon/provider/favourite_product.dart';

import '../../functions.dart';
import 'cart_screen.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  int _favouriteIndex = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: KbodyColor,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0,
                      height > 360.0 ? height * 0.04 : height * 0.13, 15.0, 0),
                  child: Container(
                    height: height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 24.0,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, CartScreen.id);
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            size: 24.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  product.pCategory,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 32.0,
                    letterSpacing: 1.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      height > 360.0 ? width * 0.07 : width * 0.06,
                      height * 0.02,
                      height > 360.0 ? width * 0.07 : width * 0.06,
                      height * 0.02),
                  height: height > 360.0 ? height * 0.75 : height * 1.5,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: height > 360.0
                                      ? height * 0.5
                                      : height * 0.8,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: ExactAssetImage(
                                          product.pImageLocation,
                                        ),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            addFavouriteProduct(product);
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            size: 25.0,
                                            color: _favouriteIndex % 2 == 0
                                                ? KmainColor
                                                : Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      product.pName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 11.0),
                                          child:
                                              customCircleButton(Icons.add, add),
                                        ),
                                        Text(
                                          _quantity.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 11.0),
                                          child: customCircleButton(
                                              Icons.remove, subtract),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  product.pDescription,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '\$${product.pPrice}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                    Builder(
                                      builder: (context) => RaisedButton(
                                        onPressed: () {
                                          addToCart(context, product, _quantity);
                                        },
                                        color: KmainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Text(
                                          'Add to cart',
                                          style: TextStyle(
                                            color: KwhiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customCircleButton(IconData icon, Function function) {
    return ClipOval(
      child: Material(
        color: KmainColor,
        child: GestureDetector(
          onTap: () {
            function();
          },
          child: SizedBox(
            child: Icon(
              icon,
              color: Colors.white,
            ),
            height: 30.0,
            width: 30.0,
          ),
        ),
      ),
    );
  }

  add() {
    if (_quantity < 50) {
      setState(() {
        _quantity++;
      });
    }
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void addFavouriteProduct(Product favoriteProduct) {
    FavouriteProduct favouriteProduct =
    Provider.of<FavouriteProduct>(
        context,
        listen: false);
    setState(() {
      _favouriteIndex++;
    });
    if (_favouriteIndex % 2 == 0) {
      favouriteProduct.addToFavouriteList(favoriteProduct);
    } else {
      favouriteProduct.removeFromFavouriteList();
    }
  }
}
