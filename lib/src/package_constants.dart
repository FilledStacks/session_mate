import 'package:flutter/foundation.dart';

const bool kRecordUserInteractions =
    !kDebugMode || bool.fromEnvironment('RECORD_SESSION');
const bool kForceDriverUI = bool.fromEnvironment('FORCE_DRIVER_UI');
const bool kUseFakeData = bool.fromEnvironment('USE_FAKE_DATA');
const bool kRunningIntegrationTest = bool.fromEnvironment('INTEGRATION_TEST');
const bool kLocalOnlyUsage = bool.fromEnvironment('LOCAL_ONLY');

const String kLocalServerScheme = 'http';
const String kLocalServerHost = 'localhost';

const List<String> commonKeysToExcludeOnDataMasking = [
  'uid',
  'id',
  'code',
  'view',
];

const double kHorizontalPadding = 10;
const double kVerticalPadding = 30;

const double kSessionItemTopPadding = 8;

const double SCROLLABLE_DETECTION_FORGIVENESS = 10.0;
