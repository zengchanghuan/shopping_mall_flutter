import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../serivces/screen_adapter.dart';

class CartNum extends StatefulWidget {
  final Map _itemData;

  const CartNum(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartNum> createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  late Map _itemData;

  @override
  void initState() {
    super.initState();
    _itemData = widget._itemData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(164),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
        children: [_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }

  //左侧按钮

  Widget _leftBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: const Text("-"),
      ),
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: const Text("+"),
      ),
    );
  }

//中间
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(70),
      decoration: const BoxDecoration(
          border: Border(
        left: BorderSide(width: 1, color: Colors.black12),
        right: BorderSide(width: 1, color: Colors.black12),
      )),
      height: ScreenAdapter.height(45),
      child: Text("${_itemData["count"]}"),
    );
  }
}
