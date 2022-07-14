import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import '../../serivces/screen_adapter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    ];

    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              imgList[index]["url"],
              fit: BoxFit.fill,
            );
          },
          itemCount: imgList.length,
          pagination: const SwiperPagination(),
          autoplay: true),
    );
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
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
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
                  padding: EdgeInsets.only(top:ScreenAdapter.height(10)),
                  height: ScreenAdapter.height(44),
                  child: Text("第$index条"),
                )
              ],
            );
          }),
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
        _titleWidget("热门推荐"),
        _hotProductListWidget(),
      ],
    );
  }
}
