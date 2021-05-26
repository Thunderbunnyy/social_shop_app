import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Widget buildImage(ParseFileBase image) {
  return FutureBuilder<ParseFileBase>(
    future: image.download(),
    builder: (BuildContext context, AsyncSnapshot<ParseFileBase> snapshot) {
      if (snapshot.hasData) {
        if (kIsWeb) {
          return Image.memory(
            (snapshot.data as ParseWebFile).file,
            fit: BoxFit.cover,
            width: double.infinity,
          );
        } else {
          return Image.file((snapshot.data as ParseFile).file,fit: BoxFit.cover,
            width: double.infinity);
        }
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}
