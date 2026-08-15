class NearrException implements Exception {
  final String code;
  final String message;

  const NearrException({required this.code, required this.message});

  @override
  String toString() {
    return 'NearrException('
        'code: $code, '
        'message: $message'
        ')';
  }
}
