import 'immutable_medicine.dart';

class MedicineRepository {
  Future<ImmutableMedicine> fetchMedicine() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    return ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
    );
  }
}
