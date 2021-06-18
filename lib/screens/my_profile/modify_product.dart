import 'package:flutter/material.dart';

class ModifyProductScreen extends StatefulWidget {
  final String productId;

  const ModifyProductScreen({Key key, this.productId}) : super(key: key);

  @override
  _ModifyProductScreenState createState() => _ModifyProductScreenState();
}

class _ModifyProductScreenState extends State<ModifyProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.productId),
    );
  }
}
