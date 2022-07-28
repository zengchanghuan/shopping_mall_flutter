import 'package:flutter/material.dart';

class AddressEdit extends StatefulWidget {
  const AddressEdit({Key? key}) : super(key: key);

  @override
  State<AddressEdit> createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("修改收货地址"),
        ),
        body: const Text("修改收货地址"));
  }
}
