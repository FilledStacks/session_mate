class ConfigurationService {
  bool _dataMaskingEnabled = true;
  bool get dataMaskingEnabled => _dataMaskingEnabled;

  List<String> _excludeKeysOnDataMasking = const [];
  List<String> get excludeKeysOnDataMasking => _excludeKeysOnDataMasking;

  int _minimumStartupTime = 5000;
  int get minimumStartupTime => _minimumStartupTime;

  void setValues({
    bool? dataMaskingEnabled,
    List<String>? excludeKeysOnDataMasking,
    int? minimumStartupTime,
  }) {
    _dataMaskingEnabled = dataMaskingEnabled ?? _dataMaskingEnabled;
    _excludeKeysOnDataMasking =
        excludeKeysOnDataMasking ?? _excludeKeysOnDataMasking;
    _minimumStartupTime = minimumStartupTime ?? _minimumStartupTime;
  }
}
