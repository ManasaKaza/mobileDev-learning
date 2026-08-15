extension NearrStringExtensions on String {
  String get normalized {
    return trim();
  }

  bool get isBlank {
    return trim().isEmpty;
  }

  String get capitalized {
    final value = trim();

    if (value.isEmpty) {
      return value;
    }

    return '${value[0].toUpperCase()}${value.substring(1)}';
  }
}
