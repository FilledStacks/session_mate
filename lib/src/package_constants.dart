const bool _recordSession = bool.fromEnvironment(
  'RECORD_SESSION',
  defaultValue: false,
);

const bool kRecordUserInteractions = _recordSession;

const double kHorizontalPadding = 10;
const double kVerticalPadding = 30;

const double kSessionItemTopPadding = 8;
