import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate_core/session_mate_core.dart';

class SessionReplayService {
  final Map<String, String> _requests = {};

  final Map<String, NetworkEvent> _cache = {};

  NetworkEvent? _currentEvent;

  bool get _isCurrentEventARequest =>
      _currentEvent != null && _currentEvent is RequestEvent;

  void handleEvent(NetworkEvent event) {
    _currentEvent = event;
    if (event is RequestEvent) {
      _requests[event.uid] = hashEvent(event);
    }
  }

  void populateCache(List<NetworkEvent> events) {
    print(
      'SessionService - populate ${events.length} network events into cache',
    );

    for (var e in events) {
      _cache[(e as ResponseEvent).uid] = e;
    }
  }

  Future<List<int>> getSanitizedData(List<int> data, {String? uid}) async {
    if (kRecordUserInteractions) return data;

    while (_isCurrentEventARequest) {
      await Future.delayed(Duration(microseconds: 100));
    }

    if (uid == null) return data;

    final response = _cache[_requests[uid]] as ResponseEvent?;

    if (response == null) return data;

    if (response.headers['content-type']!.contains('image')) {
      // return globalPlaceHolder;
      return gPlaceHolder;
    }

    return response.body ?? data;
  }
}
