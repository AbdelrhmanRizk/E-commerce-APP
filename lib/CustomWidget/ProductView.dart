import 'package:flutter/material.dart';

import 'package:e_commerce_app/functions.dart';
import '../Models/Product.dart';
import '../Screens/Product_Info.dart';


Widget productView(String pCategory,List<Product> allProducts) {
  List<Product> products=[];
  products = getProductByCategory(pCategory,allProducts);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
    ),
    itemBuilder: (context, index) => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(ProductInfo.id,arguments: products[index]);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(products[index].pImageLocation),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  color: Colors.white,
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].pName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$ ${products[index].pPrice}')
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    itemCount: products.length,
  );
}