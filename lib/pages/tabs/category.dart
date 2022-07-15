import 'package:flutter/material.dart';
import '../../serivces/screen_adapter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1334));

    //计算右侧GridView宽高比
    //左侧宽度
    var leftWidth = ScreenAdapter.getScreenWidth() / 4;

    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3

    var rightItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - 20 - 20) / 3;

    //获取计算后的宽度
    rightItemWidth = ScreenAdapter.width(rightItemWidth);

    //获取计算后的高度
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);
    return Row(
      children: <Widget>[
        SizedBox(
          width: leftWidth,
          height: double.infinity,
          // color: Colors.red,
          child: ListView.builder(
            itemCount: 28,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = index;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdapter.height(56),
                      color: _selectIndex == index ? Colors.red : Colors.white,
                      child: Text("第$index条", textAlign: TextAlign.center),
                    ),
                  ),
                  const Divider()
                ],
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: const EdgeInsets.all(10),
              height: double.infinity,
              color: const Color.fromRGBO(240, 246, 246, 0.9),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: rightItemWidth / rightItemHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: 18,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                            "https://www.itying.com/images/flutter/list8.jpg",
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: ScreenAdapter.height(28),
                        child: const Text("女装"),
                      )
                    ],
                  );
                },
              )),
        )
      ],
    );
  }
}
