import 'package:flutter/cupertino.dart';
import 'package:raia_rgon/models/product.dart';

class FavouriteProduct extends ChangeNotifier{
  List<Product> favouriteProducts = [];
  addToFavouriteList(Product favouriteProduct){
    favouriteProducts.add(favouriteProduct);
    notifyListeners();
  }
  removeFromFavouriteList(){
    favouriteProducts.removeLast();
    notifyListeners();
  }
}