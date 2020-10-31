import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:raia_rgon/consestsnt.dart';
import 'package:raia_rgon/models/product.dart';
import 'package:raia_rgon/provider/cart_item.dart';
import 'package:raia_rgon/provider/favourite_product.dart';
import 'package:raia_rgon/services/store.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _favouriteIndex = 1;

  void addFavouriteProduct(Product favoriteProduct) {
    FavouriteProduct favouriteProduct =
        Provider.of<FavouriteProduct>(context, listen: false);
    setState(() {
      _favouriteIndex++;
    });
    if (_favouriteIndex % 2 == 0) {
      favouriteProduct.addToFavouriteList(favoriteProduct);
    } else {
      favouriteProduct.removeFromFavouriteList();
    }
  }

  TextStyle customTextStyle() {
    return TextStyle(
      fontSize: 15.0,
      color: Colors.grey,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    List<Product> cartProducts = Provider.of<CartItem>(context).products;

    return Scaffold(
      backgroundColor: KbodyColor,
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: KbodyColor,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LayoutBuilder(builder: (context, constrains) {
                if (cartProducts.isNotEmpty) {
                  return Container(
                    height: height -
                        statusBarHeight -
                        appBarHeight -
                        (height * .08),
                    child: ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: height > 360.0
                                  ? height * 0.04
                                  : height * 0.09,
                              bottom: height > 360.0
                                  ? height * 0.03
                                  : height * 0.08,
                              left:
                                  height > 360.0 ? width * 0.15 : width * 0.09,
                              right: height > 360.0
                                  ? width - (width * 0.8 + width * 0.15)
                                  : (width - (width * 0.8 + width * 0.15)) *
                                      0.5),
                          child: Container(
                            height:
                                height > 360.0 ? height * 0.45 : height * 0.6,
                            width: height > 360.0 ? width * 0.8 : width * 1,
                            decoration: BoxDecoration(
                              color: KbodyColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Card(
                              color: KbodyColor,
                              elevation: 7.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: height > 360.0
                                        ? height * 0.3
                                        : height * 0.6,
                                    width: height > 360.0
                                        ? width * 0.8
                                        : width * 1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                          cartProducts[index].pImageLocation,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: height > 360.0
                                        ? height * 0.05
                                        : height * 0.15,
                                    width: height > 360.0
                                        ? width * 0.8
                                        : width * 1,
                                    decoration: BoxDecoration(
                                      color: KbodyColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            cartProducts[index].pName,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(),
                                          ),
                                          Text(
                                            '${cartProducts[index].pQuantity} items',
                                            style: customTextStyle(),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            '\$${cartProducts[index].pPrice},00',
                                            style: customTextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width: height > 360.0
                                        ? width * 0.8
                                        : width * 1,
                                    decoration: BoxDecoration(
                                      color: KbodyColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        customContainer(
                                          KmainColor,
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: KwhiteColor,
                                              size: 30.0,
                                            ),
                                            onPressed: () {
                                              Provider.of<CartItem>(context,
                                                      listen: false)
                                                  .removeFromCartList(index);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                      height: height -
                          (height * 0.08) -
                          appBarHeight -
                          statusBarHeight,
                      child: Image(
                        image: AssetImage('images/icons/emptycart.png'),
                      ),
                    ),
                  );
                }
              }),
              ButtonTheme(
                minWidth: width,
                height: height * 0.08,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: height > 360.0 ? width * 0.15 : width * 0.09,
                  ),
                  child: Builder(builder: (context) {
                    return RaisedButton(
                      onPressed: () {
                        showCustomDialog(cartProducts, context);
                      },
                      child: Text(
                        'Order',
                        style: TextStyle(
                          color: KwhiteColor,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      color: KmainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customContainer(Color color, Widget child) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.0)),
        child: child,
      ),
    );
  }

  void showCustomDialog(List<Product> products, context) async {
    var price = getTotalPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: MaterialButton(
            onPressed: () {
              try {
                Store _store = Store();
                _store.storeOrders({
                  KTotalPrice: price,
                  KAddress: address,
                }, products);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.grey.shade700,
                    content: Text(
                      'Ordered Successfully',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                );
                Navigator.pop(context);
              } catch (e) {
                print(e.message);
              }
            },
            child: Text('Confirm'),
            minWidth: 250,
            color: KmainColor,
          ),
        ),
      ],
      title: Text('Total price = \$ $price'),
      content: TextField(
        cursorColor: KmainColor,
        onChanged: (value) {
          address = value;
        },
        style: TextStyle(
          color: Colors.grey.shade700,
        ),
        decoration: InputDecoration(
          hintText: 'Enter your address',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: KmainColor,
              width: 2.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: KmainColor,
              width: 2.0,
            ),
          ),
          suffixIcon: Icon(
            Icons.add_location,
            color: KsecondColor,
          ),
        ),
      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}

/*Positioned(
                      bottom: 0,
                      child: Material(
                        color: KbodyColor,
                        child: ButtonTheme(
                          minWidth: width,
                          height: height * 0.08,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: height > 360.0 ? width * 0.15 : width * 0.09,
                            ),
                            child: Builder(builder: (context) {
                              return RaisedButton(
                                onPressed: () {
                                  showCustomDialog(cartProducts, context);
                                },
                                child: Text(
                                  'Order',
                                  style: TextStyle(
                                    color: KwhiteColor,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                color: KmainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),*/
/*arguments: cartProducts[index]*/
//padding: EdgeInsets.only(bottom: height * 0.06),
/*Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height > 360.0
                                          ? height * 0.04
                                          : height * 0.09,
                                      bottom: height > 360.0
                                          ? height * 0.03
                                          : height * 0.08,
                                      left: height > 360.0
                                          ? width * 0.15
                                          : width * 0.09,
                                      right: height > 360.0
                                          ? width - (width * 0.8 + width * 0.15)
                                          : (width - (width * 0.8 + width * 0.15)) *
                                          0.5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: height > 360.0
                                              ? height * 0.3
                                              : height * 0.6,
                                          width: height > 360.0
                                              ? width * 0.8
                                              : width * 1,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            image: DecorationImage(
                                              image: ExactAssetImage(
                                                cartProducts[index].pImageLocation,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: height > 360.0
                                              ? height * 0.05
                                              : height * 0.15,
                                          width: height > 360.0
                                              ? width * 0.8
                                              : width * 1,
                                          decoration: BoxDecoration(
                                            color: KbodyColor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  cartProducts[index].pName,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(),
                                                ),
                                                Text(
                                                  '${cartProducts[index].pQuantity} items',
                                                  style: customTextStyle(),
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                Text(
                                                  '\$${cartProducts[index].pPrice},00',
                                                  style: customTextStyle(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50.0,
                                          width: height > 360.0
                                              ? width * 0.8
                                              : width * 1,
                                          decoration: BoxDecoration(
                                            color: KbodyColor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              customContainer(
                                                KmainColor,
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: KwhiteColor,
                                                    size: 30.0,
                                                  ),
                                                  onPressed: () {
                                                    Provider.of<CartItem>(context,
                                                        listen: false)
                                                        .removeFromCartList(index);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );*/
/*ButtonTheme(
            minWidth: width,
            height: height * 0.08,
            child: Padding(
              padding: EdgeInsets.only(
                left: height > 360.0 ? width * 0.15 : width * 0.09,
              ),
              child: Builder(builder: (context) {
                return RaisedButton(
                  onPressed: () {
                    showCustomDialog(cartProducts, context);
                  },
                  child: Text(
                    'Order',
                    style: TextStyle(
                      color: KwhiteColor,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  color: KmainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                    ),
                  ),
                );
              }),
            ),
          ),*/
/*Center(
                  child: Container(
                    height: height - (height * 0.08) - appBarHeight - statusBarHeight,
                    child: Image(
                      image: AssetImage('images/icons/emptycart.png'),
                    ),
                  ),
                );*/
