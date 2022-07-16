import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../serivces/screen_adapter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/config.dart';
import 'package:dio/dio.dart';
import '../model/product_model.dart';
import '../widget/loading_widget.dart';

class ProductList extends StatefulWidget {
  final Map arguments;

  const ProductList({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //用于上拉分页
  final ScrollController _scrollController = ScrollController(); //listview 的控制器

  //分页
  int _page = 1;

  //每页有多少条数据
  final int _pageSize = 8;

  //数据
  final List _productList = [];

  /*
  排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  */
  final String _sort = "";

  //解决重复请求的问题
  bool flag = true;

  //是否有数据
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _getProductListData();

    //监听滚动条滚动事件
    _scrollController.addListener(() {
      //_scrollController.position.pixels //获取滚动条滚动的高度
      //_scrollController.position.maxScrollExtent  //获取页面高度
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (flag && _hasMore) {
          _getProductListData();
        }
      }
    });
  }

  //获取商品列表的数据
  _getProductListData() async {
    setState(() {
      flag = false;
    });

    var api =
        '${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=$_page&sort=$_sort&pageSize=$_pageSize';

    if (kDebugMode) {
      print(api);
    }
    var result = await Dio().get(api);

    var productList = ProductModel.fromJson(result.data);

    if (kDebugMode) {
      print(productList.result.length);
    }

    if (productList.result.length < _pageSize) {
      setState(() {
        // _productList = productList.result;
        _productList.addAll(productList.result);
        _hasMore = false;
        flag = true;
      });
    } else {
      setState(() {
        // _productList = productList.result;
        _productList.addAll(productList.result);
        _page++;
        flag = true;
      });
    }
  }

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

  //显示加载中的圈圈
  Widget _showMore(index) {
    if (_hasMore) {
      return (index == _productList.length - 1)
          ? const LoadingWidget()
          : const Text("");
    } else {
      return (index == _productList.length - 1)
          ? const Text("--我是有底线的--")
          : const Text("");
    }
  }

  //商品列表
  Widget _productListWidget() {
    if (_productList.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            //处理图片
            String pic = _productList[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            //每一个元素
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.height(180),
                      child: Image.network(pic, fit: BoxFit.cover),
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
                            Text("${_productList[index].title}",
                                maxLines: 2, overflow: TextOverflow.ellipsis),
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
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9),
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
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9),
                                  ),
                                  child: const Text("126"),
                                ),
                              ],
                            ),
                            Text(
                              "¥${_productList[index].price}",
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(height: 20),
                _showMore(index)
              ],
            );
          },
          itemCount: _productList.length,
        ),
      );
    } else {
      //加载中
      return const LoadingWidget();
    }
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
        body: _hasMore
            ? Stack(
                children: <Widget>[
                  _productListWidget(),
                  _subHeaderWidget(),
                ],
              )
            : const Center(
                child: Text("没有您要浏览的数据"),
              ));
  }
}
