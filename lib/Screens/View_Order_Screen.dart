import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

import '../Models/Order.dart';
import '../services/Store.dart';
import 'Order_Details_Screen.dart';

class ViewOrderScreen extends StatelessWidget {
  static String id = 'ViewOrderScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'There Is No Order',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.docs) {
              orders.add(
                Order(
                  documentId: doc.id,
                  address: doc.data()[kAddress],
                  totalPrice: doc.data()[kTotalPrice],
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(OrderDetailScreen.id,arguments: orders[index].documentId);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height *0.2,
                    color: KSecondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Price = \$${orders[index].totalPrice} ',style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Address is ${orders[index].address}',style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
