mixin ValidationMixin {
  void requireNotBlank({required String value, required String fieldName}) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(value, fieldName, 'cannot be blank');
    }
  }

  void requireNonNegative({required int value, required String fieldName}) {
    if (value < 0) {
      throw ArgumentError.value(value, fieldName, 'cannot be negative');
    }
  }
}
