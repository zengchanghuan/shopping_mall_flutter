import 'dart:developer';

import 'package:flutter/material.dart';
import 'routers/router.dart';
import 'provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'provider/check_out_provider.dart';
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckOutProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        initialRoute: "/",
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
      ),
    );
  }
}
