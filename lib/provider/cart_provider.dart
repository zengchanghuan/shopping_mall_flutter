import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List _cartList = [];

  int get cartNum => _cartList.length;
  List get cartList => _cartList;

  addData(value){
    _cartList.add(value);
    notifyListeners();
  }

  deleteData(value){
    _cartList.remove(value);
    notifyListeners();
  }
}