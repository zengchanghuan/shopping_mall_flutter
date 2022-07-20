import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../widget/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductContentSecond extends StatefulWidget {
  final List _productContentList;

  const ProductContentSecond(this._productContentList, {Key? key})
      : super(key: key);

  @override
  State<ProductContentSecond> createState() => _ProductContentSecondState ();
}

class _ProductContentSecondState extends State<ProductContentSecond> with AutomaticKeepAliveClientMixin {
  dynamic _id;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _id = widget._productContentList[0].sId;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
            child: WebView(
              initialUrl: "https://jdmall.itying.com/pcontent?id=$_id",
            ))
      ],
    );
  }
}
