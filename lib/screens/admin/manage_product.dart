import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:raia_rgon/consestsnt.dart';
import 'package:raia_rgon/models/product.dart';
import 'package:raia_rgon/services/store.dart';
import 'package:raia_rgon/widgets/custom_popupmenu.dart';

import 'edit_product.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  Store _store = new Store();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: GestureDetector(
                    onTapUp: (details) {
                      double dx1 = details.globalPosition.dx;
                      double dy1 = details.globalPosition.dy;
                      double dx2 = width - dx1;
                      double dy2 = width - dy1;
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx1, dy1, dx2, dy2),
                        items: [
                          MyPopupMenuItem(
                            child: Text('Edit'),
                            onClick: (){
                              Navigator.pushNamed(context, EditProduct.id, arguments: products[index]);
                            },
                          ),
                          MyPopupMenuItem(
                            child: Text('Delete'),
                            onClick: (){
                              _store.deleteProduct(products[index].pId);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                    child: Card(
                      elevation: 8.0,
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
                                height: height > 360.0 ? 50.0 : 70.0,
                                width: width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01,
                                      horizontal: height * 0.01),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
      ),
    );
  }
}


