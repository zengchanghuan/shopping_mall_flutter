import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../serivces/screen_adapter.dart';
import '../../widget/JdButton.dart';

class ProductContentFirst extends StatefulWidget {
  const ProductContentFirst({Key? key}) : super(key: key);

  @override
  State<ProductContentFirst> createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          //注意：最新版本的Flutter中不存在点击BottomSheet消失的问题，所以外层可以不加GestureDetector事件
          return Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenAdapter.width(100),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenAdapter.height(22)),
                                child: const Text("颜色: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(610),
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenAdapter.width(100),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenAdapter.height(22)),
                                child: const Text("风格: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(610),
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenAdapter.width(100),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenAdapter.height(22)),
                                child: const Text("尺寸: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(610),
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(76),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: JdButton(
                          color: const Color.fromRGBO(253, 1, 0, 0.9),
                          text: "加入购物车",
                          cb: () {
                            if (kDebugMode) {
                              print('加入购物车');
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: JdButton(
                            color: const Color.fromRGBO(255, 165, 0, 0.9),
                            text: "立即购买",
                            cb: () {
                              if (kDebugMode) {
                                print('立即购买');
                              }
                            },
                          )),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network("https://www.itying.com/images/flutter/p1.jpg",
                fit: BoxFit.cover),
          ),
          //标题
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text("联想ThinkPad 翼480（0VCD） 英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑",
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenAdapter.size(36))),
          ),
          Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                  "震撼首发，15.9毫米全金属外观，4.9毫米轻薄窄边框，指纹电源按钮，杜比音效，2G独显，预装正版office软件",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenAdapter.size(28)))),
          //价格
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      const Text("特价: "),
                      Text("¥28",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdapter.size(46))),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text("原价: "),
                      Text("¥50",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdapter.size(28),
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: ScreenAdapter.height(80),
            child: InkWell(
              onTap: () {
                _attrBottomSheet();
              },
              child: Row(
                children: const <Widget>[
                  Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("115，黑色，XL，1件")
                ],
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: ScreenAdapter.height(80),
            child: Row(
              children: const <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
