import 'validation_mixin.dart';

class MedicineDraftValidator with ValidationMixin {
  void validate({required String medicineName, required int remainingTablets}) {
    requireNotBlank(value: medicineName, fieldName: 'medicineName');

    requireNonNegative(value: remainingTablets, fieldName: 'remainingTablets');
  }
}
