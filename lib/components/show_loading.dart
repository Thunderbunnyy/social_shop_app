import 'package:flutter/material.dart';
import 'package:social_shop_app/components/loader.dart';

Widget showLoading() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlipLoader(),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text("one sec"),
        ),
      ],
    ),
  );
}

