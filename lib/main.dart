import 'package:fiton/constant.dart';
import 'package:fiton/provider/google_sign_in.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider (
    // TODO: implement build
    create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitOn',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w700,
            color: kHeaderColor,
          ),
          headline5: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        fontFamily: 'Poppins',
      ),
      home: LoginScreen(),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'FitOn',
//       theme: ThemeData(
//         textTheme: TextTheme(
//           headline1: TextStyle(
//             fontSize: 64,
//             fontWeight: FontWeight.w700,
//             color: kHeaderColor,
//           ),
//           headline5: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.w700,
//           ),
//           bodyText1: TextStyle(
//             fontSize: 13.0,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         fontFamily: 'Poppins',
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
