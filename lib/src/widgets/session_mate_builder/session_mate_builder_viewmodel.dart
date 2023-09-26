import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:stacked/stacked.dart';

class SessionMateBuilderViewModel extends BaseViewModel {
  final bool dataMaskingEnabled;
  final List<String> keysToExcludeOnDataMasking;
  final int minimumStartupTime;
  SessionMateBuilderViewModel({
    this.dataMaskingEnabled = true,
    this.keysToExcludeOnDataMasking = const [],
    this.minimumStartupTime = 5000,
  });

  final _configurationService = locator<ConfigurationService>();

  void init() {
    _configurationService.setValues(
      dataMaskingEnabled: dataMaskingEnabled,
      keysToExcludeOnDataMasking: keysToExcludeOnDataMasking,
      minimumStartupTime: minimumStartupTime,
    );
  }
}
