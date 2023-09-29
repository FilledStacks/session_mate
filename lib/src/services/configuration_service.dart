import 'package:session_mate/src/package_constants.dart';

class ConfigurationService {
  bool _dataMaskingEnabled = true;
  bool get dataMaskingEnabled => _dataMaskingEnabled;

  List<String> _keysToExcludeOnDataMasking = const [];
  List<String> get keysToExcludeOnDataMasking => _keysToExcludeOnDataMasking;

  List<String> get allKeysToExclude => [
        ...commonKeysToExcludeOnDataMasking,
        ..._keysToExcludeOnDataMasking,
      ];

  int _minimumStartupTime = 5000;
  int get minimumStartupTime => _minimumStartupTime;

  int _listeningPort = 3000;
  int get listeningPort => _listeningPort;

  String? _apiKey;
  String get apiKey => _apiKey!;
  bool get hasApiKey => _apiKey != null;

  void setValues({
    bool? dataMaskingEnabled,
    List<String>? keysToExcludeOnDataMasking,
    int? minimumStartupTime,
    int? listeningPort,
    String? apiKey,
  }) {
    _dataMaskingEnabled = dataMaskingEnabled ?? _dataMaskingEnabled;
    _keysToExcludeOnDataMasking =
        keysToExcludeOnDataMasking ?? _keysToExcludeOnDataMasking;
    _minimumStartupTime = minimumStartupTime ?? _minimumStartupTime;
    _listeningPort = listeningPort ?? _listeningPort;
    _apiKey = apiKey;
  }
}
