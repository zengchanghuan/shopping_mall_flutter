import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ProductContentThird extends StatefulWidget {
  const ProductContentThird({Key? key}) : super(key: key);

  @override
  State<ProductContentThird> createState() => _ProductContentThirdState();
}

class _ProductContentThirdState extends State<ProductContentThird> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context,index){
        return ListTile(
          title: Text("第$index条"),
        );

      },
    );
  }
}
