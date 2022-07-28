import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../serivces/screen_adapter.dart';
import '../widget/JdButton.dart';
import '../widget/JdText.dart';

class RegisterSecond extends StatefulWidget {
  const RegisterSecond({Key? key}) : super(key: key);

  @override
  State<RegisterSecond> createState() => _RegisterSecondState();
}

class _RegisterSecondState extends State<RegisterSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("用户注册-第二步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text("请输入xxx手机收到的验证码,请输入xxx手机收到的验证码"),
            ),
            const SizedBox(height: 40),
            Stack(
              children: <Widget>[
                JdText(
                  text: "请输入验证码",
                  onChanged: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                  },
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: ElevatedButton(
                    child: const Text('重新发送'),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              cb: () {
                Navigator.pushNamed(context, '/registerThird');
              },
            )
          ],
        ),
      ),
    );
  }
}
