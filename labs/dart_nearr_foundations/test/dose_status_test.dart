import 'package:dart_nearr_foundations/dose_status.dart';
import 'package:test/test.dart';

void main() {
  test('missed dose requires attention', () {
    final status = DoseStatus.missed;

    expect(status.requiresAttention, isTrue);

    expect(status.label, 'Missed');
  });

  test('taken dose is completed', () {
    expect(DoseStatus.taken.isCompleted, isTrue);
  });
}
