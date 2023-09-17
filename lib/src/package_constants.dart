import 'package:flutter/foundation.dart';

const bool kRecordUserInteractions =
    !kDebugMode || bool.fromEnvironment('RECORD_SESSION');
const bool kForceDriverUI = bool.fromEnvironment('FORCE_DRIVER_UI');

const double kHorizontalPadding = 10;
const double kVerticalPadding = 30;

const double kSessionItemTopPadding = 8;
