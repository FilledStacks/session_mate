import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/helpers/response_filter_helper.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

final _configurationService = locator<ConfigurationService>();

void logRequest(RequestEvent event) {
  if (!_configurationService.logNetworkData) return;

  print('');
  print('------- SESSION MATE NETWORKING: Request 🔼 -------');
  print(event.toJson());
  print('-------------------------------------------------');
  print('');
}

void logResponse(ResponseEvent event) {
  if (!_configurationService.logNetworkData) return;

  print('');
  print('------- SESSION MATE NETWORKING: Response 🔽 -------');
  if (hasJsonContentType(event) || hasXmlContentType(event)) {
    print(event.toJson());
    return;
  }

  print('Content Type neither JSON nor XML');
  print('-------------------------------------------------');
  print('');
}
