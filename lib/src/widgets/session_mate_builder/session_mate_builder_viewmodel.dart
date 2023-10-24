import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:stacked/stacked.dart';

class SessionMateBuilderViewModel extends BaseViewModel {
  final String? apiKey;
  final bool dataMaskingEnabled;
  final List<String> keysToExcludeOnDataMasking;
  final int minimumStartupTime;
  final bool logNetworkData;
  final bool verboseLogs;

  SessionMateBuilderViewModel({
    this.apiKey,
    this.dataMaskingEnabled = true,
    this.keysToExcludeOnDataMasking = const [],
    this.minimumStartupTime = 5000,
    this.logNetworkData = false,
    this.verboseLogs = false,
  });

  final _configurationService = locator<ConfigurationService>();

  bool get enabled => _configurationService.enabled;

  void init() {
    _configurationService.setValues(
      apiKey: apiKey,
      dataMaskingEnabled: dataMaskingEnabled,
      keysToExcludeOnDataMasking: keysToExcludeOnDataMasking,
      minimumStartupTime: minimumStartupTime,
      logNetworkData: logNetworkData,
      verboseLogs: verboseLogs,
    );
  }
}
