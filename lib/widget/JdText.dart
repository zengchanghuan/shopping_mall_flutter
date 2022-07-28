import 'package:flutter/material.dart';
import '../services/screen_adapter.dart';

class JdText extends StatelessWidget {
  final String text;
  final bool password;
  final dynamic onChanged;
  final int maxLines;
  final double height;

  const JdText(
      {Key? key,
      this.text = "输入内容",
      this.password = false,
      required this.onChanged,
      this.maxLines = 1,
      this.height = 68})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(height),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: TextField(
        maxLines: maxLines,
        obscureText: password,
        decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        onChanged: onChanged,
      ),
    );
  }
}
