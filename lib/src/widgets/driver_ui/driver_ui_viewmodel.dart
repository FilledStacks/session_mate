import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class DriverUIViewModel extends BaseViewModel {
  final _driverCommunicationService = locator<DriverCommunicationService>();
  final _sessionService = locator<SessionService>();

  final List<UIEvent> fakeSessionInteractions = [
    UIEvent(
      position: EventPosition(x: 345.1, y: 761.8),
      type: InteractionType.tap,
    ),
    UIEvent(
      position: EventPosition(x: 140, y: 115),
      type: InteractionType.input,
      inputData: 'dane@filledstacks.com',
    ),
    UIEvent(
      position: EventPosition(x: 198.2, y: 160.4),
      type: InteractionType.input,
      inputData: 'SessionMateWorks',
    ),
  ];

  List<UIEvent> get sessionInteractions => _sessionService.uiEvents;

  void startSession() {
    _sessionService.clear();
    _sessionService.addAllEvent(fakeSessionInteractions);

    notifyListeners();

    // Fill cache with responses

    _driverCommunicationService.sendInteractions(
      _sessionService.uiEvents,
    );
  }
}
