import 'package:flutter/material.dart';
import '../../services/screen_adapter.dart';
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
  //Scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //用于上拉分页 listview 的控制器
  final ScrollController _scrollController = ScrollController();

  //分页
  int _page = 1;

  //每页有多少条数据
  final int _pageSize = 8;

  //数据
  List _productList = [];

  /*
  排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  */
  String _sort = "";

  //解决重复请求的问题
  bool flag = true;

  //是否有更多分页数据
  bool _hasMore = true;

  //分类或者搜索关键词下面是否有数据
  bool _hasData = true;

  /*二级导航数据*/
  final List _subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];

  //二级导航选中判断
  int _selectHeaderId = 1;

  //配置search搜索框的值
  final _initKeywordsController = TextEditingController();

  //分类id   如果指定类型的话注意可空  String? _cid;
  String? _cid;

  //搜索关键词  如果指定类型的话注意可空  String? _keywords;
  String? _keywords;

  @override
  void initState() {
    super.initState();

    _cid = widget.arguments["cid"];
    _keywords = widget.arguments["keywords"];
    //给search框框赋值
    if (_keywords != null) {
      _initKeywordsController.text = _keywords!; //类型断言
    }
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

    String api;

    if (_keywords == null) {
      api =
          '${Config.domain}api/plist?cid=$_cid&page=$_page&sort=$_sort&pageSize=$_pageSize';
    } else {
      api =
          '${Config.domain}api/plist?search=$_keywords&page=$_page&sort=$_sort&pageSize=$_pageSize';
    }
    print(api);

    var result = await Dio().get(api);

    var productList = ProductModel.fromJson(result.data);

    //判断是否有搜索数据
    if (productList.result.isEmpty && _page == 1) {
      setState(() {
        _hasData = false;
      });
    } else {
      _hasData = true;
    }
    //判断最后一页有没有数据
    if (productList.result.length < _pageSize) {
      setState(() {
        _productList.addAll(productList.result);
        _hasMore = false;
        flag = true;
      });
    } else {
      setState(() {
        _productList.addAll(productList.result);
        _page++;
        flag = true;
      });
    }
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

  //导航改变的时候触发
  _subHeaderChange(id) {
    if (id == 4) {
      _scaffoldKey.currentState!.openEndDrawer();
      setState(() {
        _selectHeaderId = id;
      });
    } else {
      setState(() {
        _selectHeaderId = id;
        _sort =
            "${_subHeaderList[id - 1]["fileds"]}_${_subHeaderList[id - 1]["sort"]}";

        //重置分页
        _page = 1;
        //重置数据
        _productList = [];
        //改变sort排序
        _subHeaderList[id - 1]['sort'] = _subHeaderList[id - 1]['sort'] * -1;
        //回到顶部
        if (_hasData) {
          _scrollController.jumpTo(0);
        }
        //重置_hasMore
        _hasMore = true;
        //重新请求
        _getProductListData();
      });
    }
  }

  //显示header Icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (_subHeaderList[id - 1]["sort"] == 1) {
        return const Icon(Icons.arrow_drop_down);
      }
      return const Icon(Icons.arrow_drop_up);
    }
    return const Text("");
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
          children: _subHeaderList.map((value) {
            return Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdapter.height(16), 0, ScreenAdapter.height(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${value["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: (_selectHeaderId == value["id"])
                                ? Colors.red
                                : Colors.black54),
                      ),
                      _showIcon(value["id"])
                    ],
                  ),
                ),
                onTap: () {
                  _subHeaderChange(value["id"]);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            //注意：新版本Flutter中加入Drawer后会替换默认的返回
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              controller: _initKeywordsController,
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none)),
              onChanged: (value) {
                setState(() {
                  _keywords = value;
                });
              },
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: SizedBox(
                height: ScreenAdapter.height(68),
                width: ScreenAdapter.width(80),
                child: Row(
                  children: const <Widget>[Text("搜索")],
                ),
              ),
              onTap: () {
                _subHeaderChange(1);
              },
            )
          ],
        ),
        endDrawer: const Drawer(
          child: Text("实现筛选功能"),
        ),
        body: _hasData
            ? Stack(
                children: <Widget>[
                  _productListWidget(),
                  _subHeaderWidget(),
                ],
              )
            : const Center(child: Text("没有您要浏览的数据")));
  }
}
