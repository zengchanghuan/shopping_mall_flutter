import 'package:flutter/material.dart';
import '../serivces/screen_adapter.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _keywords = "";

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
              Text("历史记录", style: Theme.of(context).textTheme.subtitle1),
              const Divider(),
              Column(
                children: const <Widget>[
                  ListTile(
                    title: Text("女装"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("女装"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("男装"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("手机"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("鞋子"),
                  ),
                  Divider(),
                ],
              ),
              const SizedBox(height: 100),
              InkWell(
                onTap: () {},
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
          ),
        ));
  }
}
