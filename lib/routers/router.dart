import 'package:flutter/material.dart';
import '../pages/address/address_add.dart';
import '../pages/address/address_edit.dart';
import '../pages/address/address_list.dart';
import '../pages/check_out.dart';
import '../pages/register_first.dart';
import '../pages/register_second.dart';
import '../pages/register_third.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/search.dart';
import '../pages/product_list.dart';
import '../pages/product_content.dart';
import '../pages/tabs/cart.dart';
import '../pages/login.dart';

//配置路由
final Map<String, Function> routes = {
  '/': (context) => const Tabs(),
  '/search': (context) => const Search(),
  '/login': (context) => const Login(),
  '/cart': (context) => const CartPage(),
  '/registerFirst': (context) => const RegisterFirst(),
  '/registerSecond': (context, {arguments}) =>
      RegisterSecond(arguments: arguments),
  '/registerThird': (context, {arguments}) =>
      RegisterThird(arguments: arguments),
  '/productList': (context, {arguments}) => ProductList(arguments: arguments),
  '/productContent': (context, {arguments}) =>
      ProductContent(arguments: arguments),
  '/checkOut': (context) => const CheckOut(),
  '/addressAdd': (context) => const AddressAdd(),
  '/addressEdit': (context) => const AddressEdit(),
  '/addressList': (context) => const AddressList(),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  } else {
    return null;
  }
};
