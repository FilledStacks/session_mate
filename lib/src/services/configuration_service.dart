import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';

bool get printVerboseLogs => locator<ConfigurationService>().verboseLogs;

class ConfigurationService {
  bool _dataMaskingEnabled = true;
  bool get dataMaskingEnabled => _dataMaskingEnabled;

  bool _inputMaskingEnabled = true;
  bool get inputMaskingEnabled => _dataMaskingEnabled;

  List<String> _keysToExcludeOnDataMasking = const [];
  List<String> get keysToExcludeOnDataMasking => _keysToExcludeOnDataMasking;

  List<String> get headersKeysToExclude => headersKeysToExcludeOnDataMasking;

  List<String> get allKeysToExclude => [
        ...commonKeysToExcludeOnDataMasking,
        ..._keysToExcludeOnDataMasking,
      ];

  int _minimumStartupTime = 5000;
  int get minimumStartupTime => _minimumStartupTime;

  int _listeningPort = 3000;
  int get listeningPort => _listeningPort;

  bool _verboseLogs = false;
  bool get verboseLogs => kReplaySession ? kVerboseLogs : _verboseLogs;

  String? _apiKey;
  String get apiKey => _apiKey!;
  bool get hasApiKey => _apiKey != null;

  bool _logRawNetworkEvents = false;
  bool get logRawNetworkEvents => _logRawNetworkEvents;

  bool _logNetworkEvents = false;
  bool get logNetworkEvents => _logNetworkEvents;

  bool _logUIEvents = false;
  bool get logUIEvents => _logUIEvents || verboseLogs;

  bool _logNavigationEvents = false;
  bool get logNavigationEvents => _logNavigationEvents || verboseLogs;

  bool _logCliEvents = false;
  bool get logCliEvents => _logCliEvents || verboseLogs;

  bool _logSweetCoreEvents = false;
  bool get logSweetCoreEvents => _logSweetCoreEvents || verboseLogs;

  bool _logGuestAppEvents = false;
  bool get logGuestAppEvents => _logGuestAppEvents || verboseLogs;

  bool _allowDataCapture = true;
  bool get allowDataCapture => _allowDataCapture;

  void setValues({
    bool? dataMaskingEnabled,
    List<String>? keysToExcludeOnDataMasking,
    int? minimumStartupTime,
    int? listeningPort,
    String? apiKey,
    bool? logRawNetworkEvents,
    bool? logNetworkEvents,
    bool? logUIEvents,
    bool? logNavigationEvents,
    bool? logCliEvents,
    bool? logSweetCoreEvents,
    bool? logGuestAppEvents,
    bool? verboseLogs,
    bool? inputMaskingEnabled,
  }) {
    _inputMaskingEnabled = inputMaskingEnabled ?? _inputMaskingEnabled;
    _dataMaskingEnabled = dataMaskingEnabled ?? _dataMaskingEnabled;
    _keysToExcludeOnDataMasking =
        keysToExcludeOnDataMasking ?? _keysToExcludeOnDataMasking;
    _minimumStartupTime = minimumStartupTime ?? _minimumStartupTime;
    _listeningPort = listeningPort ?? _listeningPort;
    _apiKey = apiKey;
    _logRawNetworkEvents = logRawNetworkEvents ?? _logRawNetworkEvents;
    _logNetworkEvents = logNetworkEvents ?? _logNetworkEvents;
    _logUIEvents = logUIEvents ?? _logUIEvents;
    _logNavigationEvents = logNavigationEvents ?? _logNavigationEvents;
    _logCliEvents = logCliEvents ?? _logCliEvents;
    _logSweetCoreEvents = logSweetCoreEvents ?? _logSweetCoreEvents;
    _logGuestAppEvents = logGuestAppEvents ?? _logGuestAppEvents;
    _verboseLogs = verboseLogs ?? _verboseLogs;
  }

  void allowDataCapturing(bool value) {
    _allowDataCapture = value;
  }
}
