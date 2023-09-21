class ConfigurationService {
  bool _dataMaskingEnabled = true;
  bool get dataMaskingEnabled => _dataMaskingEnabled;

  List<String> _excludeKeysOnDataMasking = const [];
  List<String> get excludeKeysOnDataMasking => _excludeKeysOnDataMasking;

  int _minimumStartupTime = 5000;
  int get minimumStartupTime => _minimumStartupTime;

  void setValues({
    required bool dataMaskingEnabled,
    required List<String> excludeKeysOnDataMasking,
    required int minimumStartupTime,
  }) {
    _dataMaskingEnabled = dataMaskingEnabled;
    _excludeKeysOnDataMasking = excludeKeysOnDataMasking;
    _minimumStartupTime = minimumStartupTime;
  }
}
