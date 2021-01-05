import 'package:e_commerce_app/Models/Product.dart';
import 'package:flutter/material.dart';

import '../CustomWidget/CustomTextField.dart';
import '../services/Store.dart';
import 'package:e_commerce_app/constants.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: KMainColor,
      body: Form(
          key: _globalKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.2,
              ),
              Column(
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
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        _store.editProduct(
                            ({
                              KProductName: _name,
                              KProductPrice: _price,
                              KProductDescription: _description,
                              KProductImageLocation: _imageLocation,
                              KProductCategory: _category
                            }),
                            product.pId);
                      }
                    },
                    child: Text('Edit Product'),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
