import 'package:flutter/material.dart';

import '../serivces/screen_adapter.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Widget _checkOutItem() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: ScreenAdapter.width(160),
          child: Image.network(
              "https://www.itying.com/images/flutter/list2.jpg",
              fit: BoxFit.cover),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Flutter仿京东商城项目实战视频教程", maxLines: 2),
                  const Text("白色,175", maxLines: 2),
                  Stack(
                    children: const <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child:
                            Text("￥111", style: TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("x2"),
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("结算"),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    // ListTile(
                    //   leading: Icon(Icons.add_location),
                    //   title: Center(
                    //     child: Text("请添加收货地址"),
                    //   ),
                    //   trailing: Icon(Icons.navigate_next),
                    // )
                    const SizedBox(height: 10),
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text("张三  15201681234"),
                          SizedBox(height: 10),
                          Text("北京市海淀区西二旗"),
                        ],
                      ),
                      trailing: const Icon(Icons.navigate_next),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  children: <Widget>[
                    _checkOutItem(),
                    const Divider(),
                    _checkOutItem(),
                    const  Divider(),
                    _checkOutItem()
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:const <Widget>[
                    Text("商品总金额:￥100"),
                    Divider(),
                    Text("立减:￥5"),
                    Divider(),
                    Text("运费:￥0"),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 26,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(100),
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              decoration:const BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black26))),
              child: Stack(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("总价:￥140", style: TextStyle(color: Colors.red)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      child: const Text('立即下单',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
