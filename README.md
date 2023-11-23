# Session Mate

Session replay for professional Flutter developers. 

Reproduce bugs from production instantly.

[Sign up](https://sessionmate.dev/) for early beta 

## Development

### Firebase Emulator

```bash
flutter run --dart-define-from-file=assets/environments/development.emulator.json
```

### Firebase Cloud

```bash
flutter run --dart-define-from-file=assets/environments/development.cloud.json
```

### Configuration File Example

```json
{
  "APP_BASE_URL": "https://www.googleapis.com",
  "APP_USE_FAKE_DATA": false,
  "SESSION_MATE_API_KEY": "your-api-key",
  "SESSION_MATE_BASE_URL": "http://your.domain",
  "SESSION_MATE_INTEGRATION_TEST_BACKEND_ONLY": false,
  "SESSION_MATE_INTEGRATION_TEST_LOCAL_ONLY": false,
  "SESSION_MATE_INTEGRATION_TEST_UI_ONLY": false,
  "SESSION_MATE_INTEGRATION_TEST": false,
  "SESSION_MATE_LOG_NETWORK_EVENTS": false,
  "SESSION_MATE_LOG_RAW_NETWORK_EVENTS": false,
  "SESSION_MATE_RECORD_SESSION": true,
  "SESSION_MATE_REPLAY_SESSION": false,
  "SESSION_MATE_SANDBOX_MODE": false,
  "SESSION_MATE_VERBOSE_LOGS": false
}
```