import 'dart:convert';

class EventSender {
  static sendEvent(Event event) async {
    print(_eventToString(event));
  }

  static String _eventToString(Event e) {
    final body = e.arguments['body'] == null || e.arguments['body'].isEmpty
        ? 'empty'
        : jsonDecode(String.fromCharCodes(e.arguments['body']));

    if (e.name == 'http-request') {
      return """
        UID: ${e.arguments['uid']}
        Url: ${e.arguments['url']}
        Method: ${e.arguments['method']}
        Headers: ${e.arguments['headers']}
        Body: $body
      """;
    }

    return """
        UID: ${e.arguments['uid']}
        Code: ${e.arguments['code']}
        Headers: ${e.arguments['headers']}
        Error: ${e.arguments['error']}
        Took: ${e.arguments['tookMs']} ms
        Body: $body
    """;
  }
}

abstract class Event {
  String get name;

  Map<String, dynamic> get arguments;
}
