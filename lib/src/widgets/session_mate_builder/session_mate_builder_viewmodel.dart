import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:stacked/stacked.dart';

class SessionMateBuilderViewModel extends BaseViewModel {
  final String? apiKey;
  final bool dataMaskingEnabled;
  final List<String> keysToExcludeOnDataMasking;
  final int minimumStartupTime;
  final bool logRawNetworkEvents;
  final bool logNetworkEvents;
  final bool logUIEvents;
  final bool logNavigationEvents;
  final bool logCliEvents;
  final bool logSweetCoreEvents;
  final bool logGuestAppEvents;
  final bool verboseLogs;

  SessionMateBuilderViewModel({
    this.apiKey,
    this.dataMaskingEnabled = true,
    this.keysToExcludeOnDataMasking = const [],
    this.minimumStartupTime = 5000,
    this.logRawNetworkEvents = false,
    this.logNetworkEvents = false,
    this.logUIEvents = false,
    this.logNavigationEvents = false,
    this.logCliEvents = false,
    this.logSweetCoreEvents = false,
    this.logGuestAppEvents = false,
    this.verboseLogs = false,
  });

  final _configurationService = locator<ConfigurationService>();

  void init() {
    _configurationService.setValues(
      apiKey: apiKey,
      dataMaskingEnabled: dataMaskingEnabled,
      keysToExcludeOnDataMasking: keysToExcludeOnDataMasking,
      minimumStartupTime: minimumStartupTime,
      logRawNetworkEvents: logRawNetworkEvents,
      logNetworkEvents: logNetworkEvents,
      logUIEvents: logUIEvents,
      logNavigationEvents: logNavigationEvents,
      logCliEvents: logCliEvents,
      logSweetCoreEvents: logSweetCoreEvents,
      logGuestAppEvents: logGuestAppEvents,
      verboseLogs: verboseLogs,
    );
  }
}
