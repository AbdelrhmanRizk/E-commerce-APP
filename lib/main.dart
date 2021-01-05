import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './provider/Cart_Item.dart';
import './provider/Modal_HUD.dart';
import './provider/admin_mode.dart';
import './Screens/login_screen.dart';
import './Screens/SignUp_Screen.dart';
import './Screens/Home_Screen.dart';
import './Screens/AdminHome_Screen.dart';
import './Screens/Add_Product_Screen.dart';
import './Screens/Manage_Products.dart';
import './Screens/Edit_Products.dart';
import './Screens/Product_Info.dart';
import './Screens/Cart_Screen.dart';
import './Screens/View_Order_Screen.dart';
import './Screens/Order_Details_Screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          );
        } else {
          isUserLoggedIn = snapshot.data.getBool(KKeepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModalHud>(
                create: (context) => ModalHud(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
            ],
            child: MaterialApp(
              initialRoute:
                  isUserLoggedIn ? HomeScreen.id : LoginScreen.route_name,
              routes: {
                LoginScreen.route_name: (context) => LoginScreen(),
                SignUpScreen.id: (context) => SignUpScreen(),
                HomeScreen.id: (context) => HomeScreen(),
                AdminHome.id: (context) => AdminHome(),
                AddProduct.id: (context) => AddProduct(),
                ManageProducts.id: (context) => ManageProducts(),
                EditProduct.id: (context) => EditProduct(),
                ProductInfo.id: (context) => ProductInfo(),
                CartScreen.id: (context) => CartScreen(),
                ViewOrderScreen.id: (context) => ViewOrderScreen(),
                OrderDetailScreen.id: (context) => OrderDetailScreen(),
              },
            ),
          );
        }
      },
      future: SharedPreferences.getInstance(),
    );
  }
}
