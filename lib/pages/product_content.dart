import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product_content_model.dart';
import '../serivces/screen_adapter.dart';
import '../pages/product_content/product_content_second.dart';
import '../pages/product_content/product_content_first.dart';
import '../pages/product_content/Product_content_third.dart';
import '../config/config.dart';
import '../widget/JdButton.dart';
import '../widget/loading_widget.dart';
import '../serivces/event_bus.dart';
import '../serivces/cart_services.dart';
import '../provider/cart_provider.dart';
class ProductContent extends StatefulWidget {
  final Map arguments;

  const ProductContent({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ProductContent> createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent>
    with AutomaticKeepAliveClientMixin {
  final List _productContentList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getContentData();
  }

  _getContentData() async {
    var api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';

    if (kDebugMode) {
      print(api);
    }
    var result = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(result.data);
    // print(productContent.result.pic);

    // print(productContent.result.title);

    setState(() {
      _productContentList.add(productContent.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    super.build(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: ScreenAdapter.width(400),
                child: const TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(
                      child: Text('商品'),
                    ),
                    Tab(
                      child: Text('详情'),
                    ),
                    Tab(
                      child: Text('评价'),
                    )
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                        ScreenAdapter.width(600), 76, 10, 0),
                    items: [
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.home),
                            Text("首页")
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.search),
                            Text("搜索")
                          ],
                        ),
                      )
                    ]);
              },
            )
          ],
        ),
        body: _productContentList.isNotEmpty
            ? Stack(
                children: <Widget>[
                  TabBarView(
                    children: <Widget>[
                      ProductContentFirst(_productContentList),
                      ProductContentSecond(_productContentList),
                      const ProductContentThird()
                    ],
                  ),
                  Positioned(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.width(88),
                    bottom: 16,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black26, width: 1)),
                          color: Colors.white),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(top: ScreenAdapter.height(10)),
                            width: 100,
                            height: ScreenAdapter.height(88),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.shopping_cart,
                                    size: ScreenAdapter.size(38)),
                                Text("购物车",
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.size(24)))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: const Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () async {
                                if (_productContentList[0].attr.length > 0) {
                                  eventBus.fire(ProductContentEvent("加入购物车"));
                                } else {
                                  print("加入购物车");
                                  await CartServices.addCart(_productContentList[0]);
                                  cartProvider.updateCartList();

                                }
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: const Color.fromRGBO(255, 165, 0, 0.9),
                              text: "立即购买",
                              cb: () {
                                if (_productContentList[0].attr.length > 0) {
                                  eventBus.fire(ProductContentEvent("立即购买"));
                                } else {
                                  if (kDebugMode) {
                                    print('立即购买');
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : const LoadingWidget(),
      ),
    );
  }
}
