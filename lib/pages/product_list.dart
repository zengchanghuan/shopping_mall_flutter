import 'package:flutter/material.dart';
import '../../serivces/screen_adapter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductList extends StatefulWidget {
  final Map? arguments; //Map? 表示arguments是可为空参数

  const ProductList({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdapter.height(80),
      width: ScreenAdapter.width(750),
      child: Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(80),
        // color: Colors.red,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdapter.height(16), 0, ScreenAdapter.height(16)),
                  child: const Text(
                    "综合",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdapter.height(16), 0, ScreenAdapter.height(16)),
                  child: const Text("销量", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdapter.height(16), 0, ScreenAdapter.height(16)),
                  child: const Text("价格", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdapter.height(16), 0, ScreenAdapter.height(16)),
                  child: const Text("筛选", textAlign: TextAlign.center),
                ),
                onTap: () {
                  //注意：新版本中ScaffoldState? 为可空类型 注意判断
                  if (_scaffoldKey.currentState != null) {
                    _scaffoldKey.currentState!.openEndDrawer();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //商品列表
  Widget _productListWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
      child: ListView.builder(
        itemBuilder: (context, index) {
          //每一个元素
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(180),
                    height: ScreenAdapter.height(180),
                    child: Image.network(
                        "https://www.itying.com/images/flutter/list2.jpg",
                        fit: BoxFit.cover),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenAdapter.height(180),
                      margin: const EdgeInsets.only(left: 10),
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                              "戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          Row(
                            children: <Widget>[
                              Container(
                                height: ScreenAdapter.height(36),
                                margin: const EdgeInsets.only(right: 10),
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),

                                //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromRGBO(230, 230, 230, 0.9),
                                ),

                                child: const Text("4g"),
                              ),
                              Container(
                                height: ScreenAdapter.height(36),
                                margin: const EdgeInsets.only(right: 10),
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromRGBO(230, 230, 230, 0.9),
                                ),
                                child: const Text("126"),
                              ),
                            ],
                          ),
                          const Text(
                            "¥990",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Divider(height: 20)
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1334));
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("商品列表"),
          leading: IconButton(
            //注意：新版本的Flutter中加入Drawer组件会导致默认的返回按钮失效，所以需要手动加上返回按钮
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: const <Widget>[Text("")],
        ),
        endDrawer: const Drawer(
          child: Text("实现筛选功能"),
        ),
        body: Stack(
          children: <Widget>[
            _productListWidget(),
            _subHeaderWidget(),
          ],
        ));
  }
}
