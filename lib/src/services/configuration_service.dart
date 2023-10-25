import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';

bool get printVerboseLogs => locator<ConfigurationService>().verboseLogs;

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

  bool _verboseLogs = false;
  bool get verboseLogs => _verboseLogs;

  String? _apiKey;
  String get apiKey => _apiKey!;
  bool get hasApiKey => _apiKey != null;

  bool _logRawNetworkEvents = false;
  bool get logRawNetworkEvents => _logRawNetworkEvents || verboseLogs;

  bool _logNetworkEvents = false;
  bool get logNetworkEvents => _logNetworkEvents || verboseLogs;

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
  }) {
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
}
