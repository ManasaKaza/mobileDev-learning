import 'immutable_medicine.dart';
import 'medicine_repository_contract.dart';
import 'nearr_exception.dart';
import 'operation_result.dart';

class GetMedicinesService {
  final MedicineRepositoryContract _repository;

  GetMedicinesService({required MedicineRepositoryContract repository})
    : _repository = repository;

  Future<OperationResult<List<ImmutableMedicine>>> execute() async {
    try {
      final medicines = await _repository.fetchMedicines();

      final immutableMedicines = List<ImmutableMedicine>.unmodifiable(
        medicines,
      );

      return OperationSuccess<List<ImmutableMedicine>>(immutableMedicines);
    } on NearrException catch (error) {
      return OperationFailure<List<ImmutableMedicine>>(error.message);
    } catch (_) {
      return const OperationFailure<List<ImmutableMedicine>>(
        'Unable to load medicines.',
      );
    }
  }
}
