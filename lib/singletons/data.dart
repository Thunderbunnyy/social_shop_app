class AppData {
  static final AppData _appData = new AppData._internal();

  Map<String, List<String>> optionsMap = {};

  bool isVisible = false;

  factory AppData() {
    return _appData;
  }

  AppData._internal();
}

final appData = AppData();