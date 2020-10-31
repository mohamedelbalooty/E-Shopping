import 'package:flutter/cupertino.dart';
import 'package:raia_rgon/models/product.dart';

class CartItem extends ChangeNotifier{
  List<Product> products = [];
  addToCart(Product _product){
    products.add(_product);
    notifyListeners();
  }
  removeFromCartList(int index){
    products.removeAt(index);
    notifyListeners();
  }
//  removeFromCartList(Product product){
//    products.remove(product);
//    notifyListeners();
//  }
}