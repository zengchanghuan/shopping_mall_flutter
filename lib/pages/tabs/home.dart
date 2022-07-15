import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import '../../serivces/screen_adapter.dart';
import '../../model/focus_model.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _focusData = [];

  @override
  void initState() {
    super.initState();
    _getFocusData();
  }

  _getFocusData() async {
    var api = 'https://jdmall.itying.com/api/focus';
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

  //轮播图
  Widget _swiperWidget() {
    if (_focusData.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = _focusData[index].pic;
              return Image.network(
                "https://jdmall.itying.com/${pic.replaceAll('\\', '/')}",
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
    return Container(
      height: ScreenAdapter.height(234),
      padding: EdgeInsets.all(ScreenAdapter.width(10)),
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: ScreenAdapter.height(140),
                  width: ScreenAdapter.width(140),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                  child: Image.network(
                      "https://www.itying.com/images/flutter/hot${index + 1}.jpg",
                      fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                  height: ScreenAdapter.height(44),
                  child: Text("第$index条"),
                )
              ],
            );
          }),
    );
  }

  _recProductItemWidget() {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;

    return Container(
      padding: const EdgeInsets.all(10),
      width: itemWidth,
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromRGBO(233, 233, 233, 0.9), width: 1),
      ),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.network(
                  "https://www.itying.com/images/flutter/list1.jpg",
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: const Text(
              "FILA斐乐连帽卫衣女子2021春季新款休闲时尚运动套头衫 标准白-WT 165/84A/M",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: Stack(
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "¥198.0",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("¥168.0",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1334));
    return ListView(
      children: [
        _swiperWidget(),
        SizedBox(height: ScreenAdapter.height(12)),
        _titleWidget("猜你喜欢"),
        SizedBox(height: ScreenAdapter.height(12)),
        _hotProductListWidget(),
        _titleWidget("热门推荐"),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
            ],
          ),
        )
      ],
    );
  }
}
