import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_mall_flutter/provider/cart_provider.dart';
import '../../serivces/screen_adapter.dart';
import '../cart/cart_Item.dart';
import '../../provider/Counter.dart';
import '../../provider/cart_provider.dart';
import '../../pages/check_out.dart';
class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  bool _isEdit = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }
  doCheckOut(){

    //判断用户有没有登录    保存购物车选中的数据

    Navigator.pushNamed(context, '/checkOut');
  }


  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("购物车"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.launch),
            onPressed: () {
              setState(() {
                _isEdit = !_isEdit;
              });
            },
          )
        ],
      ),
      body: cartProvider.cartList.isNotEmpty
          ? Stack(
              children: <Widget>[
                ListView(
                    children: cartProvider.cartList.map((value) {
                  return CartItem(value);
                }).toList()),
                Positioned(
                  bottom: 0,
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(78),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black12)),
                      color: Colors.white,
                    ),
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(78),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: ScreenAdapter.width(60),
                                child: Checkbox(
                                  value: cartProvider.isCheckedAll,
                                  activeColor: Colors.pink,
                                  onChanged: (val) {
                                    cartProvider.checkAll(val);
                                  },
                                ),
                              ),
                              const Text("全选"),
                              const SizedBox(
                                width: 20,
                              ),
                              _isEdit == false
                                  ? const Text("合计:   ")
                                  : const Text(""),
                              _isEdit == false
                                  ? Text("${cartProvider.allPrice}",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.red))
                                  : const Text(""),
                            ],
                          ),
                        ),
                        _isEdit == false
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                  ),
                                  onPressed: doCheckOut,
                                  child: const Text("结算",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                  ),
                                  child: const Text("删除",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    cartProvider.removeItem();
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: Text("购物车空空如也……"),
            ),
    );
  }
}
