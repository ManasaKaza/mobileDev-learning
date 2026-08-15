import 'package:dart_nearr_foundations/get_medicines_service.dart';
import 'package:dart_nearr_foundations/immutable_medicine.dart';
import 'package:dart_nearr_foundations/medicine_repository_contract.dart';
import 'package:dart_nearr_foundations/nearr_exception.dart';
import 'package:dart_nearr_foundations/operation_result.dart';
import 'package:test/test.dart';

class SuccessfulListRepository implements MedicineRepositoryContract {
  final medicines = [
    ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
    ),
    ImmutableMedicine(
      name: 'Metformin',
      remainingTablets: 20,
      reminderHours: [8, 20],
    ),
  ];

  @override
  Future<ImmutableMedicine> fetchMedicine({required String medicineId}) async {
    return medicines.first;
  }

  @override
  Future<List<ImmutableMedicine>> fetchMedicines() async {
    return medicines;
  }
}

class FailingListRepository implements MedicineRepositoryContract {
  @override
  Future<ImmutableMedicine> fetchMedicine({required String medicineId}) async {
    throw const NearrException(
      code: 'MEDICINE_NOT_FOUND',
      message: 'Medicine was not found.',
    );
  }

  @override
  Future<List<ImmutableMedicine>> fetchMedicines() async {
    throw const NearrException(
      code: 'MEDICINES_LOAD_FAILED',
      message: 'Medicines could not be loaded.',
    );
  }
}

void main() {
  group('GetMedicinesService', () {
    test('returns all medicines', () async {
      final service = GetMedicinesService(
        repository: SuccessfulListRepository(),
      );

      final result = await service.execute();

      expect(result, isA<OperationSuccess<List<ImmutableMedicine>>>());

      if (result case OperationSuccess(:final data)) {
        expect(data.length, 2);

        expect(data.first.name, 'Vitamin D');

        expect(data.last.name, 'Metformin');
      }
    });

    test('maps repository failure', () async {
      final service = GetMedicinesService(repository: FailingListRepository());

      final result = await service.execute();

      if (result case OperationFailure(:final message)) {
        expect(message, 'Medicines could not be loaded.');
      } else {
        fail('Expected OperationFailure.');
      }
    });
  });
}
