import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class DriverUIViewModel extends BaseViewModel {
  final _driverCommunicationService = locator<DriverCommunicationService>();
  final _sessionService = locator<SessionService>();

  final List<UserInteraction> fakeSessionInteractions = [
    UserInteraction(
      position: TapPosition(x: 345.1, y: 761.8),
      type: InteractionType.tap,
    ),
    UserInteraction(
      position: TapPosition(x: 140, y: 115),
      type: InteractionType.input,
      inputData: 'dane@filledstacks.com',
    ),
    UserInteraction(
      position: TapPosition(x: 198.2, y: 160.4),
      type: InteractionType.input,
      inputData: 'SessionMateWorks',
    ),
  ];

  List<UserInteraction> get sessionInteractions =>
      _sessionService.userInteractions;

  void startSession() {
    _sessionService.clear();
    _sessionService.addAllEvent(fakeSessionInteractions);

    notifyListeners();

    _driverCommunicationService.sendInteractions(
      _sessionService.userInteractions,
    );
  }
}
