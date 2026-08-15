import 'immutable_medicine.dart';
import 'medicine_repository_contract.dart';
import 'nearr_exception.dart';

class FakeMedicineRepository implements MedicineRepositoryContract {
  final Map<String, ImmutableMedicine> _medicines;

  FakeMedicineRepository({Map<String, ImmutableMedicine>? medicines})
    : _medicines =
          medicines ??
          {
            'med_1': ImmutableMedicine(
              name: 'Vitamin D',
              remainingTablets: 14,
              reminderHours: [8, 20],
              note: 'Take after breakfast',
            ),
            'med_2': ImmutableMedicine(
              name: 'Metformin',
              remainingTablets: 20,
              reminderHours: [8, 20],
            ),
          };

  @override
  Future<ImmutableMedicine> fetchMedicine({required String medicineId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final medicine = _medicines[medicineId];

    if (medicine == null) {
      throw const NearrException(
        code: 'MEDICINE_NOT_FOUND',
        message: 'Medicine was not found.',
      );
    }

    return medicine;
  }

  @override
  Future<List<ImmutableMedicine>> fetchMedicines() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return List<ImmutableMedicine>.unmodifiable(_medicines.values);
  }
}
