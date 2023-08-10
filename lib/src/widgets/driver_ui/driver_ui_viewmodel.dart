import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class DriverUIViewModel extends BaseViewModel {
  final _driverCommunicationService = locator<DriverCommunicationService>();

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

  List<UserInteraction> sessionInteractions = [];

  void startSession() {
    sessionInteractions.clear();
    sessionInteractions.addAll(fakeSessionInteractions);

    notifyListeners();

    _driverCommunicationService.sendInteractions(sessionInteractions);
  }
}
