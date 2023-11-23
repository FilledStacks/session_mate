import 'package:flutter/foundation.dart';

const bool kRecordSession =
    !kDebugMode || bool.fromEnvironment('SESSION_MATE_RECORD_SESSION');
const bool kReplaySession = bool.fromEnvironment('SESSION_MATE_REPLAY_SESSION');
const bool kSandoxMode = bool.fromEnvironment('SESSION_MATE_SANDBOX_MODE');
const bool kRunningIntegrationTest =
    bool.fromEnvironment('SESSION_MATE_INTEGRATION_TEST');
const bool kLocalOnlyUsage =
    bool.hasEnvironment('SESSION_MATE_API_KEY') ? false : true;
const bool kVerboseLogs = bool.fromEnvironment('SESSION_MATE_VERBOSE_LOGS');

const String kLocalServerScheme = 'http';
const String kLocalServerHost = 'localhost';

const List<String> headersKeysToExcludeOnDataMasking = [
  'content-encoding',
  'content-type',
  'transfer-encoding',
];

const List<String> commonKeysToExcludeOnDataMasking = [
  'uid',
  'id',
  'code',
  'view',
  'order',
  'startedAt'
];

const List<String> mediaPlaceholders = [
  'iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAFUlEQVR42mP8z8BQz0AEYBxVSF+FABJADveWkH6oAAAAAElFTkSuQmCC',
  'iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAFUlEQVR42mNk+M9Qz0AEYBxVSF+FAAhKDveksOjmAAAAAElFTkSuQmCC',
  'iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAFUlEQVR42mNkYPhfz0AEYBxVSF+FAP5FDvcfRYWgAAAAAElFTkSuQmCC',
];

const double kHorizontalPadding = 10;
const double kVerticalPadding = 30;

const double kSessionItemTopPadding = 8;

const double kScrollableDetectionForgiveness = 10.0;
const double kEventVisualSize = 30;
