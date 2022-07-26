import 'package:flutter/material.dart';
import '../../serivces/screen_adapter.dart';
import '../../model/product_content_model.dart';

class CartCount extends StatefulWidget {
  final ProductContentitem _productContent;

  const CartCount(this._productContent, {Key? key}) : super(key: key);

  @override
  State<CartCount> createState() => _CartCountState();

}

class _CartCountState extends State<CartCount> {
  late ProductContentitem _productContent;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productContent = widget._productContent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(180),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }

  //左侧按钮

  Widget _leftBtn() {
    return InkWell(
      onTap: () {
        if (_productContent.count > 1) {
          setState(() {
            _productContent.count = _productContent.count - 1;
          });
        }
      },
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
      onTap: () {
        setState(() {
          _productContent.count = _productContent.count + 1;
        });
      },
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
      child: Text("${_productContent.count}"),
    );
  }
}
