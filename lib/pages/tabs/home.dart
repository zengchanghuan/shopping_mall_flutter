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
      height: ScreenAdapter.height(40),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,designSize: const Size(750,1624));
    return ListView(
      children: [
        _swiperWidget(),
        const SizedBox(height: 10),
        _titleWidget("猜你喜欢"),
        const SizedBox(height: 10),
        _titleWidget("热门推荐"),
      ],
    );
  }
}
