import 'package:flutter/material.dart';
import '../serivces/screen_adapter.dart';
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
            onTap: (){


            },
          )
        ],
      ),
      body: Text('搜索'),
    );
  }
}
