import 'immutable_medicine.dart';
import 'medicine_repository_contract.dart';
import 'nearr_exception.dart';
import 'operation_result.dart';

class GetMedicineService {
  final MedicineRepositoryContract _repository;

  GetMedicineService({required MedicineRepositoryContract repository})
    : _repository = repository;

  Future<OperationResult<ImmutableMedicine>> execute({
    required String medicineId,
  }) async {
    final normalizedId = medicineId.trim();

    // Validate before calling repository.
    if (normalizedId.isEmpty) {
      return const OperationFailure<ImmutableMedicine>(
        'Medicine ID cannot be empty.',
      );
    }

    try {
      final medicine = await _repository.fetchMedicine(
        medicineId: normalizedId,
      );

      return OperationSuccess<ImmutableMedicine>(medicine);
    } on NearrException catch (error) {
      // Convert known repository/domain exception
      // into an application-level failure.
      return OperationFailure<ImmutableMedicine>(error.message);
    } catch (_) {
      // Do not expose unexpected internal errors to the UI.
      return const OperationFailure<ImmutableMedicine>(
        'Something unexpected went wrong.',
      );
    }
  }
}
