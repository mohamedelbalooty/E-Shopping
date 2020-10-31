import 'package:flutter/material.dart';
import 'package:raia_rgon/models/product.dart';
import 'package:raia_rgon/screens/user/product_info.dart';
import '../functions.dart';

Widget productView(String categoryName, List<Product> allProduct) {
  List<Product> products = [];
//  List<Product> products; == List<Product> products = []; //TODO NO ADDED
  products = getProductByCategory(categoryName, allProduct);
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
            onTap: (){
              Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
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
                          vertical: MediaQuery.of(context).size.height * 0.01,
                          horizontal: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
}
