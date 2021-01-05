import 'dart:ui';

import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/Product.dart';
import '../provider/Cart_Item.dart';
import 'Cart_Screen.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(product.pImageLocation),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(CartScreen.id);
                    },
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Opacity(
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.pName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              product.pDescription,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '\$${product.pPrice}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: KMainColor,
                                    child: GestureDetector(
                                      onTap: add,
                                      child: SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  _quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 60,
                                  ),
                                ),
                                ClipOval(
                                  child: Material(
                                    color: KMainColor,
                                    child: GestureDetector(
                                      onTap: subtract,
                                      child: SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    opacity: 0.5,
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Builder(
                      builder: (context) => RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        color: KMainColor,
                        onPressed: () {
                          addToCart(context, product);
                        },
                        child: Text(
                          'Add To Cart'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productInCart = cartItem.products;
    for (var productInCart in productInCart) {
      if (productInCart.pImageLocation == product.pImageLocation) {
        exist = true;
      }
    }
    if (exist) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('You \'ve Added This Item Before'),
        ),
      );
    } else {
      cartItem.addProduct(product);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Added To Cart'),
        ),
      );
    }
  }
}
