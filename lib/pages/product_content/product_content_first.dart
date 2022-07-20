import 'package:flutter/material.dart';

class ProductContentFirst extends StatefulWidget {
  const ProductContentFirst({Key? key}) : super(key: key);

  @override
  State<ProductContentFirst> createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
  @override
  Widget build(BuildContext context) {
    return Text("商品页面");
  }
}
