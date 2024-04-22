// ignore_for_file: prefer_const_constructors

import 'package:fake_store_listofmap/controller/cart_screen_controller.dart';
import 'package:fake_store_listofmap/controller/home_screen_controller.dart';
import 'package:fake_store_listofmap/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => HomeScreenController()),
      ChangeNotifierProvider(create: (context) => CartScreenController())
    ], child: MaterialApp(home: HomeScreen()));
  }
}
