import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate_core/session_mate_core.dart';

class SessionReplayService {
  final Map<String, NetworkEvent> _cache = {};

  NetworkEvent? _currentEvent;
  String? _latestRequestEventHash;

  bool get _isCurrentEventARequest =>
      _currentEvent != null && _currentEvent is RequestEvent;

  void handleEvent(NetworkEvent event) {
    _currentEvent = event;
    if (event is RequestEvent) {
      _latestRequestEventHash = hashEvent(event.copyWith(
        uid: '',
        body: event.hasBody ? event.body : null,
      ));
    }
  }

  void populateCache(List<NetworkEvent> events) {
    print('SessionService - populate network cache');
    NetworkEvent? hashable;
    for (var e in events) {
      if (e is RequestEvent) {
        hashable = e.copyWith(
          uid: '',
          body: e.hasBody ? e.body : null,
        );
        continue;
      }

      if (hashable == null) return;

      _cache.putIfAbsent(hashEvent(hashable), () => e);
    }
  }

  Future<List<int>> replaceData(List<int> data) async {
    if (kRecordUserInteractions) return data;

    while (_isCurrentEventARequest) {
      await Future.delayed(Duration(microseconds: 100));
    }

    final response = _cache[_latestRequestEventHash];
    if (response == null) return data;

    return (response as ResponseEvent).body ?? data;

    // final mockData = {"kind": "books#volumes", "totalItems": 666, "items": []};

    // return jsonEncode(mockData).codeUnits;
  }
}
