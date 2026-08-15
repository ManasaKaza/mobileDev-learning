import 'immutable_medicine.dart';

abstract interface class MedicineRepositoryContract {
  Future<ImmutableMedicine> fetchMedicine({required String medicineId});

  Future<List<ImmutableMedicine>> fetchMedicines();
}
