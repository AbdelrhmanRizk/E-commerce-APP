import 'package:flutter/material.dart';

import 'Add_Product_Screen.dart';
import 'Manage_Products.dart';
import '../constants.dart';
import 'View_Order_Screen.dart';

class AdminHome extends StatelessWidget {
  static const String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: (){
              Navigator.of(context).pushNamed(AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.of(context).pushNamed(ManageProducts.id);
            },
            child: Text('Edit Product'),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.of(context).pushNamed(ViewOrderScreen.id);
            },
            child: Text('View Orders'),
          ),
        ],
      ),
    );
  }
}
