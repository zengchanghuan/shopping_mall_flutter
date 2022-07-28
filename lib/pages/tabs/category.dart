import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../config/config.dart';
import '../../services/screen_adapter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cate_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  //左侧分类
  _getLeftCateData() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    // print(leftCateList.result);
    setState(() {
      _leftCateList = leftCateList.result;
    });
    _getRightCateData(leftCateList.result[0].sId);
  }

  //右侧分类
  _getRightCateData(pid) async {
    var api = '${Config.domain}api/pcate?pid=$pid';
    if (kDebugMode) {
      print("右侧分类 $api");
    }
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    // print(rightCateList.result);
    setState(() {
      _rightCateList = rightCateList.result;
    });
  }

  Widget _leftCateWidget(leftWidth) {
    if (_leftCateList.isNotEmpty) {
      return SizedBox(
        width: leftWidth,
        height: double.infinity,
        // color: Colors.red,
        child: ListView.builder(
          itemCount: _leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectIndex = index;
                      _getRightCateData(_leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(84),
                    padding: EdgeInsets.only(top: ScreenAdapter.height(24)),
                    color: _selectIndex == index
                        ? const Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                    child: Text("${_leftCateList[index].title}",
                        textAlign: TextAlign.center),
                  ),
                ),
                const Divider(height: 1),
              ],
            );
          },
        ),
      );
    } else {
      return SizedBox(width: leftWidth, height: double.infinity);
    }
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (_rightCateList.isNotEmpty) {
      return Expanded(
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
              itemCount: _rightCateList.length,
              itemBuilder: (context, index) {
                //处理图片
                String pic = _rightCateList[index].pic;
                pic = Config.domain + pic.replaceAll('\\', '/');

                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/productList',
                        arguments: {"cid": _rightCateList[index].sId});
                  },
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(pic, fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: ScreenAdapter.height(28),
                        child: Text("${_rightCateList[index].title}"),
                      )
                    ],
                  ),
                );
              },
            )),
      );
    } else {
      return Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: double.infinity,
            color: const Color.fromRGBO(240, 246, 246, 0.9),
            child: const Text("加载中..."),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.center_focus_weak, size: 28, color: Colors.black87),
          onPressed: null,
        ),
        title: InkWell(
          child: Container(
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.search),
                Text("笔记本", style: TextStyle(fontSize: ScreenAdapter.size(28)))
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.message, size: 28, color: Colors.black87),
            onPressed: null,
          )
        ],
      ),
      body: Row(
        children: <Widget>[
          _leftCateWidget(leftWidth),
          _rightCateWidget(rightItemWidth, rightItemHeight)
        ],
      ),
    );
  }
}
