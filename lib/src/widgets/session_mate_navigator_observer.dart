import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/configuration_service.dart';

import 'session_mate_route_tracker.dart';

class SessionMateNavigatorObserver extends NavigatorObserver {
  SessionMateNavigatorObserver._();

  static final instance = SessionMateNavigatorObserver._();

  final _configurationService = locator<ConfigurationService>();
  final _routeTracker = locator<SessionMateRouteTracker>();

  @override
  void didPop(Route route, Route? previousRoute) {
    if (!_configurationService.enabled) return;

    _routeTracker.setCurrentRoute(_getRouteName(previousRoute));
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (!_configurationService.enabled) return;

    _routeTracker.setCurrentRoute(_getRouteName(route));
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (!_configurationService.enabled) return;

    _routeTracker.setCurrentRoute(_getRouteName(newRoute));
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  /// Creates a unique name for each bottom nav tab to ensure widgets are captured
  /// as if each tab is a new view
  void setBottomNavIndex({
    required int index,
    required String viewName,
  }) {
    if (!_configurationService.enabled) return;

    _routeTracker.changeRouteIndex(viewName, index);
  }

  String _getRouteName(Route? route) {
    return route?.settings.name ?? 'NoView';
  }
}
