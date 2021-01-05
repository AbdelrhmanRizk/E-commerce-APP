import 'package:e_commerce_app/Screens/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../provider/Modal_HUD.dart';
import '../constants.dart';
import '../CustomWidget/CustomTextField.dart';
import '../services/auth.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static const String id = 'SignUpScreen';
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
        backgroundColor: KMainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModalHud>(context).isLoading,
          child: Form(
            key: _globalKey,
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
                    //_email=value;
                  },
                  icon: Icons.perm_identity,
                  hint: 'Enter your name',
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  onClick: (value) {
                    _email = value;
                  },
                  hint: 'Enter your email',
                  icon: Icons.email,
                ),
                SizedBox(
                  height: height * 0.01,
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
                    builder:(context)=> FlatButton(
                      onPressed: () async {
                        final modalHud = Provider.of<ModalHud>(context,listen: false);
                        modalHud.changeIsLoading(true);
                        if (_globalKey.currentState.validate()) {
                          try {
                            _globalKey.currentState.save();
                            await _auth.signUp(_email.trim(), _password.trim());
                            modalHud.changeIsLoading(false);
                            Navigator.pushNamed(context, HomeScreen.id);
                          }catch (e) {
                            modalHud.changeIsLoading(false);
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.message,
                                ),
                              ),
                            );
                          }
                        }
                        modalHud.changeIsLoading(false);
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Sign up',
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
                      'Do have an account ? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
