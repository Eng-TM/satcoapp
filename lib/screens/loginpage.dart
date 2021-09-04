import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satco_app/brand_colors.dart';
import 'package:satco_app/screens/mainpage.dart';
import 'package:satco_app/screens/registrationpage.dart';
import 'package:satco_app/widgets/ProgressDialog.dart';
import 'package:satco_app/widgets/TaxiButton.dart';

class LoginPage extends StatefulWidget {

  static const String id = 'login';

  @override
  _LoginPage2State createState() => _LoginPage2State();
}


class _LoginPage2State extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailControlar = TextEditingController();

  var passwordControlar = TextEditingController();

  void login() async {

    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Logging you in',),
    );

    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: emailControlar.text,
      password: passwordControlar.text,
    ).catchError((ex){

      //check error and display message
      Navigator.pop(context);
      PlatformException thisEx = ex;
      showSnackBar(thisEx.message);

    })).user;

    if(user != null) {
      //verify login
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users/${user.uid}');
      userRef.once().then((DataSnapshot snapshot) {

        if(snapshot.value != null){
          Navigator.pop(context);
           Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 70,),
                Image(
                  alignment: Alignment.center,
                  height: 150.0,
                  width: 150.0,
                  image: AssetImage('images/logo.png'),
                ),

                SizedBox(height: 40,),

                Text('Sign In a Rider',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children:<Widget>[
                      TextField(
                        controller: emailControlar,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ),

                      SizedBox(height: 10,),

                      TextField(
                        controller: passwordControlar,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ),

                      SizedBox(height: 40,),

                     TaxiButton(
                       title: 'LOGIN',
                       color: BrandColors.colorGreen,
                       onPressed: () async {

                         //check network availability

                         var connectivityResult = await Connectivity().checkConnectivity();
                         if(connectivityResult !=ConnectivityResult.mobile && connectivityResult !=ConnectivityResult.wifi){
                           showSnackBar('No internet connectivity');
                           return;
                         }

                         if(!emailControlar.text.contains('@')){
                           showSnackBar('please enter a valid email address');
                           return;
                         }

                         if(passwordControlar.text.length<8){
                           showSnackBar('please enter a valid email password');
                           return;
                         }

                         login();

                       },
                     ),



                    ],
                  ),
                ),

                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, RegistrationPage.id, (route) => false);
                  },
                    child: Text('Don\'t have an account, sign up here')
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}

