import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/config.dart';
import '../../serivces/screen_adapter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cate_model.dart';
class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  void initState(){
    super.initState();
    _getLeftCateData();
  }
  //左侧分类
  _getLeftCateData() async{
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
  _getRightCateData(pid) async{
    var api = '${Config.domain}api/pcate?pid=$pid';
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    // print(rightCateList.result);
    setState(() {
      _rightCateList = rightCateList.result;
    });
  }

  Widget _leftCateWidget(leftWidth){

    if(_leftCateList.isNotEmpty){

      return SizedBox(
        width: leftWidth,
        height: double.infinity,
        // color: Colors.red,
        child: ListView.builder(
          itemCount: _leftCateList.length,
          itemBuilder: (context,index){
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState(() {
                      _selectIndex= index;
                      _getRightCateData(_leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(84),
                    padding: EdgeInsets.only(top:ScreenAdapter.height(24)),
                    color: _selectIndex==index? const Color.fromRGBO(240, 246, 246, 0.9):Colors.white,
                    child: Text("${_leftCateList[index].title}",textAlign: TextAlign.center),
                  ),
                ),
                const Divider(height: 1),
              ],
            );
          },

        ),
      );
    }else{
      return SizedBox(
          width: leftWidth,
          height: double.infinity
      );
    }
  }

  Widget _rightCateWidget(rightItemWidth,rightItemHeight){

    if(_rightCateList.isNotEmpty){
      return Expanded(
        flex: 1,
        child: Container(
            padding: const EdgeInsets.all(10),
            height: double.infinity,
            color: const Color.fromRGBO(240, 246, 246, 0.9),
            child: GridView.builder(

              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:3,
                  childAspectRatio: rightItemWidth/rightItemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
              ),
              itemCount: _rightCateList.length,
              itemBuilder: (context,index){

                //处理图片
                String pic=_rightCateList[index].pic;
                pic=Config.domain+pic.replaceAll('\\', '/');

                return Column(
                  children: <Widget>[

                    AspectRatio(
                      aspectRatio: 1/1,
                      child: Image.network(pic,fit: BoxFit.cover),
                    ),
                    SizedBox(
                      height: ScreenAdapter.height(28),
                      child: Text("${_rightCateList[index].title}"),
                    )
                  ],
                );
              },
            )
        ),
      );
    }else{
      return Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: double.infinity,
            color: const Color.fromRGBO(240, 246, 246, 0.9),
            child: const Text("加载中..."),
          )
      );

    }
  }


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
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth,rightItemHeight)
      ],
    );

  }
}
