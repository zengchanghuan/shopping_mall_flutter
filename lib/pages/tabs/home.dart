import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import '../../serivces/screen_adapter.dart';
import '../../model/focus_model.dart';
import 'package:dio/dio.dart';
import '../../config/config.dart';
import '../../model/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    // print(focusData.data is Map);
    var focusList = FocusModel.fromJson(result.data);

    if (kDebugMode) {
      print(focusList.result);
    }
    // for (var value in focusList.result) {
    //   print(value.title);
    //   print(value.pic);
    // }

    setState(() {
      _focusData = focusList.result;
    });
  }

  //获取猜你喜欢的数据
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    setState(() {
      _hotProductList = hotProductList.result;
    });
  }

  //获取热门推荐的数据
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    setState(() {
      _bestProductList = bestProductList.result;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    if (_focusData.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = _focusData[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return Image.network(
                pic,
                fit: BoxFit.fill,
              );
            },
            itemCount: _focusData.length,
            pagination: const SwiperPagination(),
            autoplay: true),
      );
    } else {
      return const Text('加载中...');
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.height(35),
      //外边距
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      //边距
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: ScreenAdapter.width(10),
      ))),
      child: Text(
        value,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }

  //热门推荐
  Widget _hotProductListWidget() {
    if (_hotProductList.isNotEmpty) {
      return Container(
        height: ScreenAdapter.height(234),
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //处理图片
            String sPic = _hotProductList[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');

            return InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/productContent',
                    arguments: {"id": _hotProductList[index].sId});
              },
              child: Column(
                children: <Widget>[
                  Container(
                    height: ScreenAdapter.height(140),
                    width: ScreenAdapter.width(140),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(21)),
                    child: Image.network(sPic, fit: BoxFit.cover),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                    height: ScreenAdapter.height(44),
                    child: Text(
                      "¥${_hotProductList[index].price}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: _hotProductList.length,
        ),
      );
    } else {
      return const Text("");
    }
  }

  //推荐商品
  Widget _recProductListWidget() {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: _bestProductList.map((value) {
          //图片
          String sPic = value.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');

          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/productContent',
                  arguments: {"id": value.sId});
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              width: itemWidth,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                      //防止服务器返回的图片大小不一致导致高度不一致问题
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        sPic,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Text(
                      "${value.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "¥${value.price}",
                            style:
                                const TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("¥${value.oldPrice}",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ScreenUtil.init(context, designSize: const Size(750, 1334));
    return ListView(
      children: [
        _swiperWidget(),
        SizedBox(height: ScreenAdapter.height(12)),
        _titleWidget("猜你喜欢"),
        SizedBox(height: ScreenAdapter.height(12)),
        _hotProductListWidget(),
        _titleWidget("热门推荐"),
        _recProductListWidget()
      ],
    );
  }


}
