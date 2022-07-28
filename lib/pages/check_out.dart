import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/event_bus.dart';
import '../config/config.dart';
import '../services/event_bus.dart';
import '../services/screen_adapter.dart';
import '../provider/check_out_provider.dart';
import '../services/sign_services.dart';
import '../services/user_sevices.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  List _addressList=[];
  @override
  void initState() {
    super.initState();
    _getDefaultAddress();

    //监听广播
    eventBus.on<CheckOutEvent>().listen((event) {
      if (kDebugMode) {
        print(event.str);
      }
      _getDefaultAddress();
    });
  }

  _getDefaultAddress() async {
    List userinfo = await UserServices.getUserInfo();

    // print('1234');
    var tempJson = {
      "uid": userinfo[0]["_id"],
      "salt": userinfo[0]["salt"]
    };
    var sign = SignServices.getSign(tempJson);
    var api = '${Config.domain}api/oneAddressList?uid=${userinfo[0]["_id"]}&sign=${sign}';
    var response = await Dio().get(api);
    if (kDebugMode) {
      print(response);
    }
    setState(() {
      _addressList=response.data['result'];
    });


  }
  Widget _checkOutItem(item) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: ScreenAdapter.width(160),
          child: Image.network("${item["pic"]}", fit: BoxFit.cover),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${item["title"]}", maxLines: 2),
                  Text("${item["selectedAttr"]}", maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥${item["price"]}",
                            style: const TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("x${item["count"]}"),
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
    var checkOutProvider = Provider.of<CheckOutProvider>(context);
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
                    SizedBox(height: 10),
                    _addressList.length>0?ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${_addressList[0]["name"]}  ${_addressList[0]["phone"]}"),
                          SizedBox(height: 10),
                          Text("${_addressList[0]["address"]}"),
                        ],
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.pushNamed(context, '/addressList');
                      },
                    ):ListTile(
                      leading: Icon(Icons.add_location),
                      title: Center(
                        child: Text("请添加收货地址"),
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.pushNamed(context, '/addressAdd');
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                    children: checkOutProvider.checkOutListData.map((value) {
                      return Column(
                        children: <Widget>[_checkOutItem(value), const Divider()],
                      );
                    }).toList()),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
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
            bottom: 0,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(100),
            child: Container(
              padding: const EdgeInsets.all(5),
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              decoration: const BoxDecoration(
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

