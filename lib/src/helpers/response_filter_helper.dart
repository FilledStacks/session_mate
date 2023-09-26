import 'package:session_mate_core/session_mate_core.dart';

bool hasImageContentType(ResponseEvent event) {
  if (!event.headers.containsKey('content-type')) return false;

  if (!(event.headers['content-type']?.contains('image') ?? false)) {
    return false;
  }

  return true;
}
