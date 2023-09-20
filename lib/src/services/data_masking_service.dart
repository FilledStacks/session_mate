class DataMaskingService {
  List<String> sensitiveKeys = [
    "id",
    "uid",
    "token",
    "code",
    "smallThumbnail",
    "thumbnail",
    "body"
  ];

  String _stringSubstitution(String item) {
    String output = '';
    for (int i = 0; i < item.length; i++) {
      if (item[i] == " ") {
        output = '$output ';
        continue;
      }

      output = '${output}x';
    }

    return output;
  }

  num _numSubstitution(num item) {
    String output = '';
    String itemToString = item.toString();
    for (int i = 0; i < itemToString.length; i++) {
      output = '${output}9';
    }

    return num.parse(output);
  }

  dynamic handle(dynamic data) {
    if (data is String) {
      return _stringSubstitution(data);
    }

    if (data is num) {
      return _numSubstitution(data);
    }

    if (data is List) {
      List itemList = [];
      for (var i in data) {
        itemList.add(handle(i));
      }

      return itemList;
    }

    if (data is Map<String, dynamic>) {
      Map<String, dynamic> itemMap = {};
      for (var i in data.entries) {
        itemMap.addAll(handle(i));
      }

      return itemMap;
    }

    if (data is MapEntry<String, dynamic>) {
      if ((data.value is String || data.value is num) &&
          sensitiveKeys.contains(data.key)) {
        return Map<String, dynamic>.fromEntries([data]);
      }

      return {data.key: handle(data.value)};
    }
  }
}
