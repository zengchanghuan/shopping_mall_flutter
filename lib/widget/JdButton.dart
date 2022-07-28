import 'package:flutter/material.dart';
import '../services/screen_adapter.dart';

class JdButton extends StatelessWidget {

  final Color color;
  final String text;
  final double height;
  final Function()? cb;  //注意：新版Flutter中需要把cb定义成Function()类型或者vconst ar类型
  const JdButton({Key? key,this.color=Colors.black,this.text="按钮",this.cb,this.height = 68}) : super(key: key);

  @override
  Widget build(BuildContext context) {   
    return InkWell(
      onTap: cb,
      child: Container(
        margin: EdgeInsets.all(ScreenAdapter.height(10)),
        padding: EdgeInsets.all(ScreenAdapter.height(10)),
        height: ScreenAdapter.height(68),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
