import 'package:flutter/material.dart';

import '../../serivces/screen_adapter.dart';
import '../../pages/cart/cart_num.dart';

class CartItem extends StatefulWidget {
  final Map _itemData;

  const CartItem(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late Map _itemData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemData = widget._itemData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(200),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: true,
              onChanged: (val) {},
              activeColor: Colors.pink,
            ),
          ),
          SizedBox(
            width: ScreenAdapter.width(160),
            child: Image.network(
                "${_itemData["pic"]}",
                fit: BoxFit.cover),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   Text(
                      "${_itemData["title"]}",
                      maxLines: 2),
                  Stack(
                    children:  <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥${_itemData["price"]}", style: TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(_itemData),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
