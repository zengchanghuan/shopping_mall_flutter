import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/storage.dart';

class CartProvider with ChangeNotifier {
  List _cartList = []; //状态
  bool _isCheckedAll = false; //状态
  double _allPrice = 0; //总价

  List get cartList => _cartList;

  bool get isCheckedAll => _isCheckedAll;

  double get allPrice => _allPrice;

  CartProvider() {
    init();
  }

  //初始化的时候获取购物车数据
  init() async {
    //注意：新版shared_preferences增加了可空类型，如果为空不会报错了，所以这里直接可以判断。
    String? cartList = await Storage.getString('cartList');
    if (cartList != null) {
      List cartListData = json.decode(cartList);
      _cartList = cartListData;
    } else {
      _cartList = [];
    }
    //获取全选的状态
    _isCheckedAll = isCheckAll();
    computeAllPrice();
    notifyListeners();
  }

  //更新购物车列表
  updateCartList() {
    init();
  }

  //数量改变触发的方法
  itemCountChange() {
    Storage.setString("cartList", json.encode(_cartList));
    computeAllPrice();
    notifyListeners();
  }

  //全选 反选
  checkAll(value) {
    for (var i = 0; i < _cartList.length; i++) {
      _cartList[i]["checked"] = value;
    }
    _isCheckedAll = value;
    computeAllPrice();

    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }

  //判断是否全选
  bool isCheckAll() {
    if (_cartList.isNotEmpty) {
      for (var i = 0; i < _cartList.length; i++) {
        if (_cartList[i]["checked"] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  //监听每一项的选中事件
  itemChange() {
    if (isCheckAll() == true) {
      _isCheckedAll = true;
    } else {
      _isCheckedAll = false;
    }
    computeAllPrice();
    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }

  //计算总价
  computeAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]["checked"] == true) {
        tempAllPrice += _cartList[i]["price"] * _cartList[i]["count"];
      }
    }
    _allPrice = tempAllPrice;
    notifyListeners();
  }

  //删除数据
  removeItem() {
    List tempList = [];
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]["checked"] == false) {
        tempList.add(_cartList[i]);
      }
    }
    _cartList = tempList;
    //计算总价
    computeAllPrice();
    Storage.setString("cartList", json.encode(_cartList));
    notifyListeners();
  }
}
