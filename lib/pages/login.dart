import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../serivces/screen_adapter.dart';
import '../widget/JdButton.dart';
import '../widget/JdText.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              cb: (){

              },
            )
          ],
        ),
      ),
    );
  }

}
