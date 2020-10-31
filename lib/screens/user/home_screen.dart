import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:raia_rgon/models/product.dart';
import 'package:raia_rgon/screens/user/product_info.dart';
import 'package:raia_rgon/services/auth.dart';
import 'package:raia_rgon/services/store.dart';
import 'package:raia_rgon/utilities/custom_drawer.dart';
import 'package:raia_rgon/widgets/product_view.dart';
import '../../consestsnt.dart';
import '../../functions.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  final Auth _auth = new Auth();
  final Store _store = new Store();
  FirebaseUser _loggedUser;
  List<Product> _products = [];
  TabController _controller;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _controller = TabController(vsync: this, length: _myTabs.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  final List<Tab> _myTabs = <Tab>[
    Tab(text: 'Jackets'),
    Tab(text: 'Trousers'),
    Tab(text: 'T-Shirts'),
    Tab(text: 'Shoes'),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: KbodyColor,
          appBar: AppBar(
            backgroundColor: KbodyColor,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Discover'.toUpperCase(),
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
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
            bottom: TabBar(
              controller: _controller,
              indicatorColor: KmainColor,
              unselectedLabelColor: Colors.grey.shade500,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.0,
              ),
              onTap: (int value) {
                setState(
                  () {
                    _tabIndex = value;
                  },
                );
              },
              tabs: <Widget>[
                _myTabs[0],
                _myTabs[1],
                _myTabs[2],
                _myTabs[3],
              ],
            ),
          ),
          drawer: CustomDrawer(),
          body: TabBarView(
            controller: _controller,
            children: <Widget>[
              jacketView(), //products 1
              productView(KTrousers, _products), //products 2
              productView(KT_Shirts, _products), //products 3
              productView(KShoes, _products), //products 4
            ],
          ),
        ),
      ],
    );
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;
            products.add(
              Product(
                pId: doc.documentID,
                pName: data[KProductName],
                pPrice: data[KProductPrice],
                pDescription: data[KProductDescription],
                pCategory: data[KProductCategory],
                pImageLocation: data[KProductImageLocation],
              ),
            );
          }
          _products = [...products];
          products.clear();
          products = getProductByCategory(KJackets, _products);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                child: Card(
                  elevation: 8.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProductInfo.id,
                          arguments: products[index]);
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              products[index].pImageLocation,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: 0.7,
                            child: Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height > 360.0
                                  ? 50.0
                                  : 70.0,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                    horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.01),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      products[index].pName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$ ${products[index].pPrice}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: products.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
