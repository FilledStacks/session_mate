import 'package:flutter/foundation.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/configuration_service.dart';

class DataMaskingService {
  final _configurationService = locator<ConfigurationService>();

  @visibleForTesting
  String stringSubstitution(String item) {
    String output = '';
    final specialCharacters = RegExp(r'[-!@#$%^&*()_+{}\[\]:;<>,.?~\\|]');
    final digits = RegExp(r'\d+');
    for (int i = 0; i < item.length; i++) {
      final currentCharacter = item[i];
      final characterIsSpecial = specialCharacters.hasMatch(currentCharacter);
      if (currentCharacter == " " || characterIsSpecial) {
        output = '$output$currentCharacter';
        continue;
      }

      final characterIsDigit = digits.hasMatch(currentCharacter);
      if (characterIsDigit) {
        output = '${output}9';
      } else {
        output = '${output}x';
      }
    }

    return output;
  }

  @visibleForTesting
  num numSubstitution(num item) {
    String output = '';
    String itemToString = item.toString();
    for (int i = 0; i < itemToString.length; i++) {
      if (itemToString[i] == ".") {
        output = '$output.';
        continue;
      }

      output = '${output}9';
    }

    return num.parse(output);
  }

  dynamic handle(dynamic data) {
    if (data is String) {
      return stringSubstitution(data);
    }

    if (data is num) {
      return numSubstitution(data);
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
          _configurationService.allKeysToExclude.contains(data.key)) {
        return Map<String, dynamic>.fromEntries([data]);
      }

      return {data.key: handle(data.value)};
    }
  }
}
