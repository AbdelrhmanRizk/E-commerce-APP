import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_app/Screens/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../provider/admin_mode.dart';
import '../provider/Modal_HUD.dart';
import '../constants.dart';
import '../CustomWidget/CustomTextField.dart';
import '../services/auth.dart';
import 'SignUp_Screen.dart';
import 'AdminHome_Screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  static const String route_name = 'LoginScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

  final _auth = Auth();



  final adminPassword = 'admin1234';

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: widget._globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/icons/buyicon.png'),
                      ),
                      Positioned(
                        bottom: 0.0,
                        child: Text(
                          'Buy it',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your email',
                icon: Icons.email,
              ),
             Padding(
               padding: const EdgeInsets.only(left:20.0),
               child: Row(
                 children: [
                   Theme(
                     data: ThemeData(
                       unselectedWidgetColor: Colors.white,
                     ),
                     child: Checkbox(
                       activeColor: KMainColor,
                         checkColor:KSecondaryColor,
                         value: keepMeLoggedIn, onChanged: (value){
                       setState(() {
                         keepMeLoggedIn = value;
                       });
                     }),
                   ),
                    Text('Remember Me',style: TextStyle(
                      color: Colors.white
                    ),),
                 ],
               ),
             ),
              CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Enter your password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    onPressed: () {
                      if(keepMeLoggedIn == true){
                        keepUserLoggedIn();
                      }
                      _validate(context);

                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account ? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUpScreen.id);
                    },
                    child: Text(
                      'SignUp',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(true);
                        },
                        child: Text(
                          'I\'m an admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? KMainColor
                                  : Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(false);
                        },
                        child: Text(
                          'I\'m a user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? Colors.white
                                  : KMainColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _validate(BuildContext context) async {
    final modalHud = Provider.of<ModalHud>(context,listen: false);
    modalHud.changeIsLoading(true);
    if (widget._globalKey.currentState.validate()) {
      widget._globalKey.currentState.save();
      if (Provider.of<AdminMode>(context,listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
           await _auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modalHud.changeIsLoading(false);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
              ),
            );
          }
        } else {
          modalHud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Something Went Wrong!'),
            ),
          );
        }
      } else {
        try {
         await _auth.signIn(_email, _password);
          Navigator.pushNamed(context, HomeScreen.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        }
      }
    }
    modalHud.changeIsLoading(false);
  }

  void keepUserLoggedIn() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.setBool(KKeepMeLoggedIn, keepMeLoggedIn);

  }
}
