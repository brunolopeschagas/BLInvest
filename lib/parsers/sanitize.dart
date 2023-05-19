class Sanitize {
  String sanitizeToNumericOnly(String value) {
    return letOnlyNumeric(
      replaceComaToDots(
        removeDots(value),
      ),
    );
  }

  String letOnlyNumeric(String value) {
    RegExp onlyNumeric = RegExp(r'[^0-9.,]');
    return value.replaceAll(onlyNumeric, '');
  }

  String removeSpaces(String string) {
    return string.trim();
  }

  String removeDots(String value) {
    return value.replaceAll('.', '');
  }

  String replaceComaToDots(String value) {
    return value.replaceAll(',', '.');
  }
}
