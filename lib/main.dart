import 'package:flutter/material.dart';
import 'package:demo_app/tools/appData.dart';
import 'package:demo_app/user_screens/categories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'user_screens/myhomepage.dart';
import  'user_screens/login.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scoped_models/products.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Demo',
      theme: ThemeData(


        primaryColor: Colors.blue,
        //accentColor: Colors.red
      ),
      debugShowCheckedModeBanner: false,
      home: Categories(),
      routes:{
        '/login':(BuildContext context)=> LoginPage(),
      } ,
    );
  }
}

