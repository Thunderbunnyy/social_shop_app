import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OptionsProvider extends ChangeNotifier {

  Map<String, dynamic> optionsMap = {};
  bool isVisible = false;
  String chosenSubcategory = 'Choose Category';

  setVisibility(){
    isVisible = true;
    notifyListeners();
  }



}