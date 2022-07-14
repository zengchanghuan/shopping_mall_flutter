import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/search.dart';
//配置路由
final Map<String, Function> routes = {
  '/': (context) => const Tabs(),
  '/search': (context) => const Search(),

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
