import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';
import '../services/Store.dart';
import '../Models/Product.dart';
import '../CustomWidget/ProductView.dart';
import 'Product_Info.dart';
import 'Cart_Screen.dart';
import 'login_screen.dart';


class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = Auth();

  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _story = Store();
  List<Product> _products=[];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              fixedColor: KMainColor,
              currentIndex: _bottomBarIndex,
              onTap: (value) async{
                if(value == 2){
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.clear();
                 await _auth.signOut();
                 Navigator.of(context).popAndPushNamed(LoginScreen.route_name);
                }
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [

                BottomNavigationBarItem(
                  label: 'Test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'Test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'Sign Out',
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: KMainColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    'Jackets',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'T-shirts',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Trousers',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : KUnActiveColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              jacketView(),
              productView(kT_shirts, _products),
              productView(kTrousers, _products),
              productView(kShoes, _products),
            ]),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(CartScreen.id);
                      },
                      child: Icon(Icons.shopping_cart)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }





  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _story.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data();
            products.add(Product(
              pName: data[KProductName],
              pPrice: data[KProductPrice],
              pCategory: data[KProductCategory],
              pImageLocation: data[KProductImageLocation],
              pDescription: data[KProductDescription],
              pId: doc.id,
            ));
          }
          _products = [...products];
          products.clear();
          products = getProductByCategory(kJackets, _products);
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
                }
                ,
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
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }
}
