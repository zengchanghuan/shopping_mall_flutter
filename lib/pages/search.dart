import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/screen_adapter.dart';
import '../services/search_services.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  dynamic _keywords;

  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    _getHistoryData();
  }

  _getHistoryData() async {
    var tempList = await SearchServices.getHistoryList();
    setState(() {
      _historyListData = tempList;
    });
  }

  _showAlertDialog(keywords) async {
    var result = await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示信息!"),
            content: const Text("您确定要删除吗?"),
            actions: <Widget>[
              TextButton(
                child: const Text("取消"),
                onPressed: () {
                  if (kDebugMode) {
                    print("取消");
                  }
                  Navigator.pop(context, 'Cancel');
                },
              ),
              TextButton(
                child: const Text("确定"),
                onPressed: () async {
                  //注意异步
                  await SearchServices.removeHistoryData(keywords);
                  _getHistoryData();
                  if (!mounted) return;
                  Navigator.pop(context, "ok");
                },
              )
            ],
          );
        });

    if (kDebugMode) {
      print(result);
    }
  }

  Widget _historyListWidget() {
    if (_historyListData.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("历史记录", style: Theme.of(context).textTheme.subtitle1),
          const Divider(),
          Column(
            children: _historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text("$value"),
                    onLongPress: () {
                      _showAlertDialog("$value");
                    },
                  ),
                  const Divider()
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  SearchServices.clearHistoryList();
                  _getHistoryData();
                },
                child: Container(
                  width: ScreenAdapter.width(400),
                  height: ScreenAdapter.height(64),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.delete),
                      Text("清空历史记录")
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      );
    } else {
      return const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none)),
              onChanged: (value) {
                _keywords = value;
              },
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: SizedBox(
                height: ScreenAdapter.height(68),
                width: ScreenAdapter.width(80),
                child: Row(
                  children: const <Widget>[Text("搜索")],
                ),
              ),
              onTap: () {
                //搜索数据存入缓存
                SearchServices.setHistoryData(_keywords);
                Navigator.pushReplacementNamed(context, '/productList',
                    arguments: {"keywords": _keywords});
              },
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Text("热搜", style: Theme.of(context).textTheme.subtitle1),
              const Divider(),
              Wrap(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("笔记本电脑"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装111"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  )
                ],
              ),
              const SizedBox(height: 10),
              //历史记录
              _historyListWidget()
            ],
          ),
        ));
  }
}
