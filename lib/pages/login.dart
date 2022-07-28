import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/config.dart';
import '../services/event_bus.dart';
import '../services/screen_adapter.dart';
import '../widget/JdButton.dart';
import '../widget/JdText.dart';
import '../services/storage.dart';
import '../services/event_bus.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //登录页面消失时通知更新状态
    eventBus.fire(UserEvent('登录成功'));
  }

  String username = '';
  String password = '';

  doLogin() async {
    RegExp reg = RegExp(r"^1\d{10}$");
    if (!reg.hasMatch(username)) {
      Fluttertoast.showToast(
        msg: '手机号格式不对',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (password.length < 6) {
      Fluttertoast.showToast(
        msg: '密码不正确',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      var api = '${Config.domain}api/doLogin';
      var response = await Dio()
          .post(api, data: {"username": username, "password": password});
      if (response.data["success"]) {
        if (kDebugMode) {
          print(response.data);
        }
        //保存用户信息
        Storage.setString('userInfo', json.encode(response.data["userinfo"]));

        if(!mounted) return;
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // title: Text("登录页面"),
        actions: <Widget>[
          TextButton(
            child:const Text("客服"),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin:const EdgeInsets.only(top: 30),
                height: ScreenAdapter.width(160),
                width: ScreenAdapter.width(160),
                child: Image.asset('images/login.png',fit: BoxFit.cover),
                // child: Image.network(
                //     'https://www.itying.com/images/flutter/list5.jpg',
                //     fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 30),
            JdText(
              text: "请输入用户名",
              onChanged: (value) {
                username = value;
                if (kDebugMode) {
                  print(value);
                }
              },
            ),
            const SizedBox(height: 10),
            JdText(
              text: "请输入密码",
              password: true,
              onChanged: (value) {
                password = value;
                if (kDebugMode) {
                  print(value);
                }
              },
            ),

            const SizedBox(height: 10),

            Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              child: Stack(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('忘记密码'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/registerFirst');
                      },
                      child: const Text('新用户注册'),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),
            JdButton(
              text:"登录",
              color: Colors.red,
              height: 74,
              cb: doLogin,
            )
          ],
        ),
      ),
    );
  }

}
