import 'package:dart_nearr_foundations/get_refill_summary_service.dart';
import 'package:dart_nearr_foundations/immutable_medicine.dart';
import 'package:dart_nearr_foundations/medicine_repository_contract.dart';
import 'package:dart_nearr_foundations/nearr_exception.dart';
import 'package:dart_nearr_foundations/operation_result.dart';
import 'package:test/test.dart';

class RefillSummaryRepository implements MedicineRepositoryContract {
  final medicine = ImmutableMedicine(
    name: 'Vitamin D',
    remainingTablets: 14,
    reminderHours: [8, 20],
  );

  @override
  Future<ImmutableMedicine> fetchMedicine({required String medicineId}) async {
    return medicine;
  }

  @override
  Future<List<ImmutableMedicine>> fetchMedicines() async {
    return [medicine];
  }
}

class MissingMedicineRepository implements MedicineRepositoryContract {
  @override
  Future<ImmutableMedicine> fetchMedicine({required String medicineId}) async {
    throw const NearrException(
      code: 'MEDICINE_NOT_FOUND',
      message: 'Medicine was not found.',
    );
  }

  @override
  Future<List<ImmutableMedicine>> fetchMedicines() async {
    return [];
  }
}

void main() {
  group('GetRefillSummaryService', () {
    test('calculates refill summary', () async {
      final service = GetRefillSummaryService(
        repository: RefillSummaryRepository(),
      );

      final result = await service.execute(medicineId: 'med_1');

      expect(result, isA<OperationSuccess<RefillSummary>>());

      if (result case OperationSuccess(:final data)) {
        expect(data.medicineName, 'Vitamin D');

        // 14 tablets / 2 reminders per day
        expect(data.daysRemaining, 7);

        expect(data.refillSoon, isFalse);
      }
    });

    test('rejects empty medicine ID', () async {
      final service = GetRefillSummaryService(
        repository: RefillSummaryRepository(),
      );

      final result = await service.execute(medicineId: '   ');

      if (result case OperationFailure(:final message)) {
        expect(message, 'Medicine ID cannot be empty.');
      } else {
        fail('Expected OperationFailure.');
      }
    });

    test('returns failure when medicine is missing', () async {
      final service = GetRefillSummaryService(
        repository: MissingMedicineRepository(),
      );

      final result = await service.execute(medicineId: 'unknown');

      if (result case OperationFailure(:final message)) {
        expect(message, 'Medicine was not found.');
      } else {
        fail('Expected OperationFailure.');
      }
    });
  });
}
