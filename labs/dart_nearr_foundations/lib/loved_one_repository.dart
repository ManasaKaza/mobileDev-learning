class LovedOneRepository {
  Future<String> fetchLovedOneName() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    return 'Amma';
  }
}
