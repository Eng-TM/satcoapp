// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:satco_app/screens/mainpage.dart';
// import 'dart:io';
//
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final FirebaseApp app = await FirebaseApp.configure(
//     name: 'db2',
//     options: Platform.isIOS
//         ? const FirebaseOptions(
//       googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
//       gcmSenderID: '297855924061',
//       databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
//     )
//         : const FirebaseOptions(
//       googleAppID: '1:2196437370:android:3e10d6d4f6a9e4c9823ec3',
//       apiKey: 'AIzaSyD1km7LXJW4ElPPUDNDD3QHPnAyTSHbZiI',
//       databaseURL: 'https://satco-app-4c095-default-rtdb.firebaseio.com',
//     ),
//   );
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MainPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satco_app/dataprovider/appdata.dart';
import 'package:satco_app/screens/loginpage.dart';
import 'package:satco_app/screens/mainpage.dart';
import 'dart:io';

import 'package:satco_app/screens/registrationpage.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
      googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
      gcmSenderID: '297855924061',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    )
        : const FirebaseOptions(
      googleAppID: '1:347179815694:android:2a1eb0153fb8aa0165fd5f',
      apiKey: 'AIzaSyCZM21weX-HjBA6LICtPyi4GVpYfT-XgKg',
      databaseURL: 'https://satco-a6e5f-default-rtdb.firebaseio.com',
    ),
  );
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        // title: 'Satco admin',
        theme: ThemeData(
          fontFamily: 'Brand-Regular',
          primarySwatch: Colors.blue,
        ),

        initialRoute: MainPage.id,
        routes: {
          RegistrationPage.id: (context) => RegistrationPage(),
          LoginPage.id: (context) => LoginPage(),
          MainPage.id: (context) => MainPage(),
        },

        debugShowCheckedModeBanner: false,

      ),
    );
  }
}
