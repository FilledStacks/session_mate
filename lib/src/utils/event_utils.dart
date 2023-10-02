class EventUtils {
  static int _eventId = 0;

  static int getEventOrder() {
    _eventId++;

    return _eventId;
  }
}
