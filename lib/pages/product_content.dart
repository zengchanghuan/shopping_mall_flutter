import 'package:flutter/material.dart';
import '../serivces/screen_adapter.dart';
import '../pages/product_content/product_content_second.dart';
import '../pages/product_content/product_content_first.dart';
import '../pages/product_content/Product_content_third.dart';

class ProductContent extends StatefulWidget {
  final Map arguments;

  const ProductContent({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ProductContent> createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  @override
  Widget build(BuildContext context) {
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
        body: Stack(
          children: <Widget>[
            const TabBarView(
              children: <Widget>[
                ProductContentFirst(),
                ProductContentSecond(),
                ProductContentThird(),
              ],
            ),
            Positioned(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.width(120),
              bottom: 10,
              child: Container(
                color: Colors.red,
                child: const Text("底部"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
