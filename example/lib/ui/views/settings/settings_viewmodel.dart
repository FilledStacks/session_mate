import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  int _counter = 0;
  String get counterTitle => 'Counter is $_counter';

  void incrementCounter() {
    _counter++;
  }
}
