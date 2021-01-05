import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/constants.dart';
import '../services/Store.dart';
import '../Models/Product.dart';

// ignore: must_be_immutable
class OrderDetailScreen extends StatelessWidget {
  static String id = 'OrderDetailScreen';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadOrdersDetails(documentId),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<Product> products=[];
              for(var doc in snapshot.data.docs){
                products.add(Product(
                  pName: doc.data()[KProductName],
                  pQuantity: doc.data()[kProductQuantity],
                  pCategory: doc.data()[KProductCategory],
                ));
              }
              return  Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder:(context, index) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height *0.2,
                          color: KSecondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Product Name : ${products[index].pName}',style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text('Product Category : ${products[index].pCategory}',style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),)
                                ,SizedBox(
                                  height: 10.0,
                                ),
                                Text('Quantity : ${products[index].pQuantity}',style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: KMainColor,
                            child: RaisedButton(
                              onPressed: (){},
                              child: Text('Confirm Order'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: KMainColor,
                            child: RaisedButton(
                              onPressed: (){},
                              child: Text('Delete Order'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else{
              return(
              Center(
                child: Text('Loading Order Details...'),
              )
              );
            }
          }),
    );
  }
}
