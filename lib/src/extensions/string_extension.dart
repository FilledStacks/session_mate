extension CapExtension on String {
  String get removePrecisionIfZero =>
      isEmpty ? '' : replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");

  String get inCaps => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  String get firstLetterInSmallLetter =>
      isEmpty ? '' : '${this[0].toLowerCase()}${substring(1)}';

  String get allInCaps => isEmpty ? '' : toUpperCase();

  String get capitalizeFirstOfEach =>
      isEmpty ? '' : split(" ").map((str) => str.inCaps).join(" ");
}

extension WidgetDescriptionStringValidation on String {
  String get convertViewNameToValidFormat {
    final trimmerText = trim();
    assert(trimmerText.isNotEmpty);

    if (trimmerText == '/') {
      return 'initialView';
    }

    return trimmerText.replaceAll('/', '').replaceAllMapped(
          RegExp(r'[/\-_\s]+([.\S])'),
          (match) => match.group(1)!.inCaps,
        );
  }
}
