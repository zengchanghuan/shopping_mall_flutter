import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/screen_adapter.dart';
import '../../services/user_sevices.dart';
import '../../services/sign_services.dart';
import '../../config/Config.dart';
import 'package:dio/dio.dart';
import '../../services/event_bus.dart';

class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  List addressList = [];

  @override
  void initState() {
    super.initState();
    _getAddressList();

    //监听增加收货地址的广播
    eventBus.on<AddressEvent>().listen((event) {
      if (kDebugMode) {
        print(event.str);
      }
      _getAddressList();
    });
  }

  //监听页面销毁的事件
  @override
  dispose() {
    super.dispose();
    eventBus.fire(CheckOutEvent('改收货地址成功...'));
  }

  //获取收货地址列表
  _getAddressList() async {
    //请求接口
    List userinfo = await UserServices.getUserInfo();

    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};

    var sign = SignServices.getSign(tempJson);

    var api =
        '${Config.domain}api/addressList?uid=${userinfo[0]['_id']}&sign=$sign';

    var response = await Dio().get(api);
    // print(response.data["result"]);

    setState(() {
      addressList = response.data["result"];
    });
  }

  //修改默认收货地址
  _changeDefaultAddress(id) async {
    List userinfo = await UserServices.getUserInfo();

    var tempJson = {
      "uid": userinfo[0]['_id'],
      "id": id,
      "salt": userinfo[0]["salt"]
    };

    var sign = SignServices.getSign(tempJson);

    var api = '${Config.domain}api/changeDefaultAddress';
    var response = await Dio()
        .post(api, data: {"uid": userinfo[0]['_id'], "id": id, "sign": sign});

    if (kDebugMode) {
      print(response);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("收货地址列表"),
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: addressList.length,
              itemBuilder: (context, index) {
                if (addressList[index]["default_address"] == 1) {
                  return Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.check, color: Colors.red),
                        title: InkWell(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${addressList[index]["name"]}  ${addressList[index]["phone"]}"),
                                const SizedBox(height: 10),
                                Text("${addressList[index]["address"]}"),
                              ]),
                          onTap: () {
                            _changeDefaultAddress(addressList[index]["_id"]);
                          },
                        ),
                        trailing: const Icon(Icons.edit, color: Colors.blue),
                      ),
                      const Divider(height: 20),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      ListTile(
                        title: InkWell(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${addressList[index]["name"]}  ${addressList[index]["phone"]}"),
                                const SizedBox(height: 10),
                                Text("${addressList[index]["address"]}"),
                              ]),
                          onTap: () {
                            _changeDefaultAddress(addressList[index]["_id"]);
                          },
                        ),
                        trailing: const Icon(Icons.edit, color: Colors.blue),
                      ),
                      const Divider(height: 20),
                    ],
                  );
                }
              },
            ),
            Positioned(
              bottom: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(88),
              child: Container(
                padding: const EdgeInsets.all(5),
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(88),
                decoration: const BoxDecoration(
                    color: Colors.red,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black26))),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.add, color: Colors.white),
                      Text("增加收货地址", style: TextStyle(color: Colors.white))
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/addressAdd');
                  },
                ),
              ),
            )
          ],
        ));
  }
}
