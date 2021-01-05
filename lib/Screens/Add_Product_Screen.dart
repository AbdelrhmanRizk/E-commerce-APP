import 'package:e_commerce_app/Models/Product.dart';
import 'package:flutter/material.dart';

import '../CustomWidget/CustomTextField.dart';
import '../services/Store.dart';
import 'package:e_commerce_app/constants.dart';
// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  static const String id = 'AddProduct';
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store= Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomTextField(
              hint: 'Product Price',
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomTextField(
              hint: 'Product Description',
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomTextField(
              hint: 'Product Category',
              onClick: (value) {
                _category = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomTextField(
              hint: 'Product Location',
              onClick: (value) {
                _imageLocation = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () {
                if(_globalKey.currentState.validate()){
                  _globalKey.currentState.save();
                  _store.addProduct(Product(
                    pName: _name,
                    pPrice: _price,
                    pCategory: _category,
                    pDescription: _description,
                    pImageLocation: _imageLocation,
                  ));


                }
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}
