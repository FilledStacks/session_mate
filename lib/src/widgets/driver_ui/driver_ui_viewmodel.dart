import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class DriverUIViewModel extends BaseViewModel {
  final _driverCommunicationService = locator<DriverCommunicationService>();
  final _sessionService = locator<SessionService>();

  final List<UIEvent> fakeSessionInteractions = [
    // UIEvent(
    //   position: EventPosition(x: 345.1, y: 761.8),
    //   type: InteractionType.tap,
    // ),
    // UIEvent(
    //   position: EventPosition(x: 140, y: 115),
    //   type: InteractionType.input,
    //   inputData: 'dane@filledstacks.com',
    // ),
    // UIEvent(
    //   position: EventPosition(x: 198.2, y: 160.4),
    //   type: InteractionType.input,
    //   inputData: 'SessionMateWorks',
    // ),
    // UIEvent(
    //   position: EventPosition(x: 261.7006138392857, y: 271.22767857142856),
    //   type: InteractionType.tap,
    // ),
    // UIEvent(
    //   position: EventPosition(x: 268.5560825892857, y: 271.98660714285717),
    //   type: InteractionType.tap,
    // ),

    UIEvent(position: EventPosition(x: 70, y: 320), type: InteractionType.tap),
    UIEvent(position: EventPosition(x: 70, y: 330), type: InteractionType.tap),
    // RESOURCES
    UIEvent(
      position: EventPosition(x: 193.13337053571428, y: 345.89285714285717),
      type: InteractionType.tap,
    ),
    UIEvent(position: EventPosition(x: 70, y: 360), type: InteractionType.tap),
    UIEvent(position: EventPosition(x: 70, y: 370), type: InteractionType.tap),
    // CHARACTERS
    UIEvent(
      position: EventPosition(x: 182.08426339285714, y: 385.89285714285717),
      type: InteractionType.tap,
    ),
    UIEvent(position: EventPosition(x: 70, y: 410), type: InteractionType.tap),
    UIEvent(position: EventPosition(x: 70, y: 420), type: InteractionType.tap),
    // LOCATIONS
    UIEvent(
      position: EventPosition(x: 221.69782366071428, y: 463.9732142857143),
      type: InteractionType.tap,
    ),
    UIEvent(position: EventPosition(x: 70, y: 490), type: InteractionType.tap),
    UIEvent(position: EventPosition(x: 70, y: 500), type: InteractionType.tap),
    // EPISODES
    UIEvent(
      position: EventPosition(x: 252.55998883928572, y: 536.3616071428571),
      type: InteractionType.tap,
    ),
    UIEvent(position: EventPosition(x: 70, y: 550), type: InteractionType.tap),
    UIEvent(position: EventPosition(x: 70, y: 570), type: InteractionType.tap),
    // CHARACTERS
    UIEvent(
      position: EventPosition(x: 170.08426339285714, y: 385.89285714285717),
      type: InteractionType.tap,
    ),
  ];

  List<UIEvent> get sessionInteractions => _sessionService.uiEvents;

  void startSession() {
    _sessionService.clear();
    // _sessionService.addAllEvent(fakeSessionInteractions);
    _sessionService.populateSession();

    notifyListeners();

    // Fill cache with responses
    _sessionService.populateCache();

    _driverCommunicationService.sendInteractions(
      _sessionService.uiEvents,
    );
  }
}
