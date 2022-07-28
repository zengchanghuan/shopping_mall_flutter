import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../services/event_bus.dart';
import '../../services/screen_adapter.dart';
import '../../services/user_sevices.dart';
import '../../widget/JdButton.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  bool isLogin = false;
  List userInfo = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserinfo();

    //监听登录页面改变的事件
    eventBus.on<UserEvent>().listen((event) {
      if (kDebugMode) {
        print(event.str);
      }
      _getUserinfo();
    });

  }

  _getUserinfo() async {
    var isLogin = await UserServices.getUserLoginState();
    var userInfo = await UserServices.getUserInfo();

    setState(() {
      this.userInfo = userInfo;
      this.isLogin = isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.init(context, designSize: const Size(750, 1334));
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("用户中心"),
        // ),
        body: ListView(
      children: <Widget>[
        Container(
          height: ScreenAdapter.height(220),
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/user_bg.jpg'), fit: BoxFit.cover)),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ClipOval(
                  child: Image.asset(
                    'images/user.png',
                    fit: BoxFit.cover,
                    width: ScreenAdapter.width(100),
                    height: ScreenAdapter.width(100),
                  ),
                ),
              ),
              !isLogin
                  ? Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text("登录/注册",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("用户名：${userInfo[0]["username"]}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.size(32))),
                          Text("普通会员",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.size(24))),
                        ],
                      ),
                    )
            ],
          ),
        ),
        const ListTile(
          leading: Icon(Icons.assignment, color: Colors.red),
          title: Text("全部订单"),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.payment, color: Colors.green),
          title: Text("待付款"),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.local_car_wash, color: Colors.orange),
          title: Text("待收货"),
        ),
        Container(
            width: double.infinity,
            height: 10,
            color: const Color.fromRGBO(242, 242, 242, 0.9)),
        const ListTile(
          leading: Icon(Icons.favorite, color: Colors.lightGreen),
          title: Text("我的收藏"),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.people, color: Colors.black54),
          title: Text("在线客服"),
        ),
        const Divider(),
        JdButton(
          text: "退出登录",
          cb: () {
            UserServices.loginOut();
            _getUserinfo();
          },
        )
      ],
    ));
  }
}
