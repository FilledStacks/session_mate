import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/extensions/string_extension.dart';
import 'package:session_mate/src/services/session_service.dart';

class SessionMateRouteTracker extends ChangeNotifier {
  SessionMateRouteTracker._();

  static final instance = SessionMateRouteTracker._();

  final _logger = getLogger('SessionMateRouteTracker');
  final _sessionService = locator<SessionService>();

  @visibleForTesting
  bool testMode = false;

  @visibleForTesting
  Map<String, int> indexedRouteStateMap = {};

  String previosRoute = '';
  String _currentRoute = '';
  String get currentRoute => _currentRoute;
  String get formatedCurrentRoute => _currentRoute.isNotEmpty
      ? _currentRoute.convertViewNameToValidFormat
      : '';

  void setCurrentRoute(String route) {
    _logger.i('route: $_currentRoute | previousRoute: $previosRoute');

    if (testMode) {
      setRoute(route);
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setRoute(route);
      _sessionService.addView(route);
      notifyListeners();
    });
  }

  void setRoute(String route) {
    previosRoute = _currentRoute;
    _currentRoute = route;
    loadRouteIndexIfExist(route);
  }

  void changeRouteIndex(String viewName, int index) {
    setCurrentRoute(viewName + index.toString());
    saveRouteIndex(viewName, index);
  }

  void saveRouteIndex(String viewName, int index) {
    indexedRouteStateMap[viewName] = index;
  }

  void loadRouteIndexIfExist(String viewName) {
    if (indexedRouteStateMap.containsKey(viewName)) {
      _currentRoute = viewName + indexedRouteStateMap[viewName].toString();
    }
  }
}
