import 'package:cloud_firestore/cloud_firestore.dart';


import '../Models/Product.dart';
import 'package:e_commerce_app/constants.dart';

class Store {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  addProduct(Product product) {
    _firebaseFirestore.collection(KProductCollection).add({
      KProductName: product.pName,
      KProductPrice: product.pPrice,
      KProductCategory: product.pCategory,
      KProductDescription: product.pDescription,
      KProductImageLocation: product.pImageLocation
    });
  }

  Stream<QuerySnapshot> loadProducts(){
    return _firebaseFirestore.collection(KProductCollection).snapshots();
  }
  Stream<QuerySnapshot> loadOrders(){
    return _firebaseFirestore.collection(kOrders).snapshots();
  }
  Stream<QuerySnapshot> loadOrdersDetails(documentId){
    return _firebaseFirestore.collection(kOrders).doc(documentId).collection(kOrderDetails).snapshots();
  }

  deleteProduct(productId){
    _firebaseFirestore.collection(KProductCollection).doc(productId).delete();
  }
  editProduct(data, productId){
    _firebaseFirestore.collection(KProductCollection).doc(productId).update(data);
  }
  storeOrder(data, List<Product> products){
   var documentRef=  _firebaseFirestore.collection(kOrders).doc();
   documentRef.set(data);
   for(var product in products) {
     documentRef.collection(kOrderDetails).doc().set({
       KProductName : product.pName,
       KProductPrice : product.pPrice,
       kProductQuantity : product.pQuantity,
       KProductImageLocation : product.pImageLocation,
       KProductCategory : product.pCategory,
     });
   }
  }

}