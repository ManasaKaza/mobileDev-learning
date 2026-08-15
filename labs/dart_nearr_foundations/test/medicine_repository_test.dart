import 'package:dart_nearr_foundations/medicine_repository.dart';
import 'package:test/test.dart';

void main() {
  test('loads medicine asynchronously', () async {
    final repository = MedicineRepository();

    final medicine = await repository.fetchMedicine();

    expect(medicine.name, 'Vitamin D');
    expect(medicine.remainingTablets, 14);
  });
}
