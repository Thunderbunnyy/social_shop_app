class AppData {
  static final AppData _appData = new AppData._internal();

  Map<String, dynamic> optionsMap = {};

  bool isVisible = false;

  String userId;
  String username;
  String subcategory;
  String productId;

  factory AppData() {
    return _appData;
  }

  AppData._internal();
}

final appData = AppData();