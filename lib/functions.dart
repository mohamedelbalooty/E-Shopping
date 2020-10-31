import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';
import 'provider/cart_item.dart';

List<Product> getProductByCategory(String value, List<Product> allProduct) {
  List<Product> products = [];
  try {
    for (var product in allProduct) {
      if (product.pCategory == value) {
        products.add(product);
      }
    }
  } on Error catch (exception) {
    print(exception);
  }
  return products;
}

void addToCart(context, Product product, int quantity) {
  CartItem cartItem = Provider.of<CartItem>(context, listen: false);
  product.pQuantity = quantity;
  bool exist = false;
  var productsInCart = cartItem.products;
  for (var productCart in productsInCart) {
    if (productCart.pName == product.pName) {
      exist = true;
    }
  }
  if (exist) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey.shade700,
        content: Text(
          'You\'ve added this item before and your item is modified.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  } else {
    cartItem.addToCart(product);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey.shade700,
        content: Text(
          'Added to Cart',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
