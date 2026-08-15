import 'medicine_repository_contract.dart';
import 'nearr_exception.dart';
import 'operation_result.dart';

typedef RefillSummary = ({
  String medicineName,
  int daysRemaining,
  bool refillSoon,
});

class GetRefillSummaryService {
  final MedicineRepositoryContract _repository;

  GetRefillSummaryService({required MedicineRepositoryContract repository})
    : _repository = repository;

  Future<OperationResult<RefillSummary>> execute({
    required String medicineId,
  }) async {
    final normalizedId = medicineId.trim();

    if (normalizedId.isEmpty) {
      return const OperationFailure<RefillSummary>(
        'Medicine ID cannot be empty.',
      );
    }

    try {
      // We need one particular medicine,
      // so medicineId is passed here.
      final medicine = await _repository.fetchMedicine(
        medicineId: normalizedId,
      );

      final daysRemaining = medicine.estimateFullDaysRemaining();

      final RefillSummary summary = (
        medicineName: medicine.name,
        daysRemaining: daysRemaining,
        refillSoon: daysRemaining <= 3,
      );

      return OperationSuccess<RefillSummary>(summary);
    } on NearrException catch (error) {
      return OperationFailure<RefillSummary>(error.message);
    } catch (_) {
      return const OperationFailure<RefillSummary>(
        'Unable to calculate refill summary.',
      );
    }
  }
}
