import 'immutable_medicine.dart';

extension MedicineListExtension on List<ImmutableMedicine> {
  List<ImmutableMedicine> get outOfStockMedicines {
    return where((medicine) => medicine.isOutOfStock).toList();
  }
}
