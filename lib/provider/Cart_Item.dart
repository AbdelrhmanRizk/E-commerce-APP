import 'package:flutter/cupertino.dart';
import '../Models/Product.dart';

class CartItem extends ChangeNotifier{
  List<Product> products=[];
  addProduct(Product product){
    products.add(product);
  }
  deleteProduct(Product product){
    products.remove(product);
    notifyListeners();
  }
}