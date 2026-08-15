import 'package:dart_nearr_foundations/dose_status.dart';
import 'package:dart_nearr_foundations/dose_status_stream.dart';
import 'package:dart_nearr_foundations/fake_medicine_repository.dart';
import 'package:dart_nearr_foundations/get_medicine_service.dart';
import 'package:dart_nearr_foundations/get_medicines_service.dart';
import 'package:dart_nearr_foundations/get_refill_summary_service.dart';
import 'package:dart_nearr_foundations/immutable_medicine.dart';
import 'package:dart_nearr_foundations/loved_one_repository.dart';
import 'package:dart_nearr_foundations/medicine_list_extension.dart';
import 'package:dart_nearr_foundations/medicine_repository.dart';
import 'package:dart_nearr_foundations/nearr_exception.dart';
import 'package:dart_nearr_foundations/operation_result.dart';
import 'package:dart_nearr_foundations/operation_result_extensions.dart';
import 'package:dart_nearr_foundations/push_reminder_sender.dart';
import 'package:dart_nearr_foundations/refill_calculator.dart';
import 'package:dart_nearr_foundations/refill_message.dart';
import 'package:dart_nearr_foundations/medicine_schedule.dart';
import 'package:dart_nearr_foundations/medicine_registry.dart';
import 'package:dart_nearr_foundations/medicine.dart';
import 'package:dart_nearr_foundations/reminder_channel.dart';
import 'package:dart_nearr_foundations/reminder_dispatcher.dart';
import 'package:dart_nearr_foundations/reminder_processor.dart';
import 'package:dart_nearr_foundations/sms_reminder_sender.dart';
import 'package:dart_nearr_foundations/string_extensions.dart';
import 'package:dart_nearr_foundations/whatsapp_reminder_sender.dart';

// void main() {
// const appName = 'Nearr';
// const tabletsPerDose = 1;
// const dosesPerDay = 2;
// const refillThresholdDays = 3;

// final medicineName = 'Morning Tablet';
// final lovedOneName = 'Amma';
// final remainingTablets = 6;
// final createdAt = DateTime.now();

// final tabletsNeededPerDay = calculateTabletsNeededPerDay(
//   tabletsPerDose: tabletsPerDose,
//   dosesPerDay: dosesPerDay,
// );

// final estimatedDaysRemaining = estimateFullDaysRemaining(
//   remainingTablets: remainingTablets,
//   tabletsNeededPerDay: tabletsNeededPerDay,
// );

// final refillStatus = determineRefillStatus(
//   estimatedDaysRemaining: estimatedDaysRemaining,
//   refillThresholdDays: refillThresholdDays,
// );

// final refillMessage = buildRefillMessage(
//   status: refillStatus,
//   medicineName: medicineName,
//   estimatedDaysRemaining: estimatedDaysRemaining,
// );

// final shouldSendAlert = shouldSendRefillAlert(
//   status: refillStatus,
//   alertsEnabled: true,
//   caregiverLinked: true,
// );

// final immediateAttention = requiresImmediateAttention(refillStatus);

// print('$appName medicine summary');
// print('Medicine: $medicineName');
// print('Loved one: $lovedOneName');
// print('Tablets remaining: $remainingTablets');
// print('Tablets required each day: $tabletsNeededPerDay');
// print('Estimated full days remaining: $estimatedDaysRemaining');
// print('Refill status: ${refillStatus.name}');
// print('Message: $refillMessage');
// print('Should send alert: $shouldSendAlert');
// print('Requires immediate attention: $immediateAttention');
// print('Summary created at: $createdAt');

// final reminderHours = createDefaultReminderHours();
// print('Initial reminder hours: $reminderHours');

// addReminderHour(reminderHours: reminderHours, hour: 6);
// print('Reminder hours after adding 6: $reminderHours');

// addReminderHour(reminderHours: reminderHours, hour: 8);
// print('Reminder hours after adding duplicate 8: $reminderHours');

// final removed = removeReminderHour(reminderHours: reminderHours, hour: 14);
// print('Removed 14: $removed');
// print('Reminder hours after removing 14: $reminderHours');

// final removed2 = removeReminderHour(reminderHours: reminderHours, hour: 14);
// print('Removed 14: $removed2');
// print('Reminder hours after removing 14: $reminderHours');

// print('Final reminders');
// for (final hour in reminderHours) {
//   print('Reminder at $hour:00');
// }

// final labels = buildReminderLabels(reminderHours);

// print('Reminder labels:');
// for (final label in labels) {
//   print(label);
// }

// final medicines = createActiveMedicineNames();

// medicines.add('Iron');
// medicines.add('Vitamin D');

// print(medicines);

// final reminderCounts = createReminderCounts();
// print(reminderCounts);

// final count = findReminderCount(
//   reminderCounts: reminderCounts,
//   medicineName: 'Aspirin',
// );

// if (count == null) {
//   print('Medicine not found.');
// } else {
//   print('Reminder count: $count');
// }

// final vitaminD = Medicine(
//   name: 'Vitamin D',
//   remainingTablets: 14,
//   reminderHours: [8, 14, 20],
//   note: 'Take after breakfast',
// );

// final metformin = Medicine(
//   name: 'Metformin',
//   remainingTablets: 30,
//   reminderHours: [8, 20],
// );

// print(vitaminD.name);
// print(metformin.name);

// print('Daily usage: ${vitaminD.calculateDailyTabletUsage()} tablets');
// print('Days remaining: ${vitaminD.estimateFullDaysRemaining()}');

// final hours = [8, 14, 20];
// final medicine = Medicine(
//   name: 'Vitamin D',
//   remainingTablets: 14,
//   reminderHours: hours,
// );
// hours.add(22);
// print('Original list: $hours');
// print('Medicine list: ${medicine.reminderHours}');

// final medicine = Medicine(
//   name: 'Vitamin D',
//   remainingTablets: 14,
//   reminderHours: [20, 8, 14],
//   note: 'Take after breakfast',
// );

// print('Medicine name: ${medicine.name}');
// print('Remaining: ${medicine.remainingTablets}');
// print('Reminders: ${medicine.reminderHours}');
// print('Daily usage: ${medicine.calculateDailyTabletUsage()}');
// print('Full days remaining: ${medicine.estimateFullDaysRemaining()}');
// print('Note: ${medicine.note}');

// medicine.recordDoseTaken();
// print('After dose: ${medicine.remainingTablets}');

// medicine.addRemainderHour(6);
// print('Updated reminders: ${medicine.reminderHours}');

// print(medicine.isOutOfStock);

// final beforeDose = ImmutableMedicine(
//   name: 'Vitamin D',
//   remainingTablets: 2,
//   reminderHours: [8],
// );

// print('Before dose: $beforeDose');

// final afterDose = beforeDose.recordDoseTaken();

// print('After dose: $afterDose');

// final medicineA = ImmutableMedicine(
//   name: 'Vitamin D',
//   remainingTablets: 14,
//   reminderHours: [8, 20],
// );

// final medicineB = ImmutableMedicine(
//   name: 'Vitamin D',
//   remainingTablets: 14,
//   reminderHours: [8, 20],
// );

// print('Medicine A: $medicineA');
// print('Medicine B: $medicineB');

// print('Are they equal? ${medicineA == medicineB}');

// print('Are they identical? ${identical(medicineA, medicineB)}');

// final original = ImmutableMedicine(
//   name: 'Vitamin D',
//   remainingTablets: 14,
//   reminderHours: [20, 8],
//   note: 'After breakfast',
// );

// final afterDose = original.recordDoseTaken();

// final withNewReminder = afterDose.addReminderHour(14);

// print('Original stock: ${original.remainingTablets}');
// print('After dose: ${afterDose.remainingTablets}');

// print('Original reminders: ${original.reminderHours}');
// print('Updated reminders: ${withNewReminder.reminderHours}');

// final pushSender = PushReminderSender();
// final whatsappSender = WhatsappReminderSender();

// pushSender.send(recipient: 'device_123', message: 'Time to take Vitamin D.');
// whatsappSender.send(
//   recipient: '+919876543210',
//   message: 'Time to take Vitamin D.',
// );

// final dispatcher = ReminderDispatcher(
//   senders: [
//     PushReminderSender(),
//     WhatsappReminderSender(),
//     SmsReminderSender(),
//   ],
// );

// print('Configured channels: ${dispatcher.channelNames}');

// dispatcher.dispatch(recipient: 'amma', message: 'Time to take Vitamin D.');

// final result = OperationResult<String>(
//   data: 'Vitamin D',
//   message: 'Medicine loaded succesfully',
// );
// print(result.data);
// print(result.message);

// final stockResult = OperationResult<int>(
//   data: 14,
//   message: 'Stock loaded succesfully',
// );
// print(stockResult.data);
// print(stockResult.message);

// final medicine = ImmutableMedicine(
//   name: 'Vitamin D',
//   remainingTablets: 14,
//   reminderHours: [8, 20],
// );

// final result = OperationResult<ImmutableMedicine>(
//   data: medicine,
//   message: 'Medicine loaded succesfully',
// );
// print(result.data.name);

// final OperationResult<String> result = OperationSuccess('Vitamin D');

// switch (result) {
//   case OperationSuccess<String>(:final data):
//     print('Success: $data');

//   case OperationFailure<String>(:final message):
//     print('Failure: $message');
// }

// Future<void> main() async {
//   final repository = MedicineRepository();

//   try {
//     final medicine = await repository.fetchMedicine();

//     print(medicine.name);
//   } on NearrException catch (error) {
//     print('Error code: ${error.code}');
//     print('Message: ${error.message}');
//   }
// }

// Future<void> main() async {
//   final lovedRepo = LovedOneRepository();
//   final medicineRepo = MedicineRepository();
//   print('Loading Nearr dashboard');
//   final med = await medicineRepo.fetchMedicine();
//   final love = await lovedRepo.fetchLovedOneName();

//   print('Medicine: ${med.name}');
//   print('Loved one: $love');

//   print('Medicine: $med');
//   print('Loved one: $love');
// }

// Future<void> main() async {
//   final stream = doseStatusUpdates();

//   await for (final status in stream) {
//     print('Dose status: $status');
//   }
// }

// Future<void> main() async {
//   await for (final remaining in reminderCountdown(seconds: 3)) {
//     print('Reminder in $remaining');
//   }
// }

// Future<void> main() async {
//   final repository = FakeMedicineRepository();

//   final getMedicineService = GetMedicineService(repository: repository);

//   final result = await getMedicineService.execute(medicineId: 'med_1');

//   switch (result) {
//     case OperationSuccess(:final data):
//       print('Medicine loaded: $data');

//     case OperationFailure(:final message):
//       print('Failed: $message');
//   }
// }

// Future<void> main() async {
//   final repository = FakeMedicineRepository();

//   final getMedicineService = GetMedicineService(repository: repository);

//   final getMedicinesService = GetMedicinesService(repository: repository);

//   final getRefillSummaryService = GetRefillSummaryService(
//     repository: repository,
//   );

//   // ------------------------------------------------
//   // GET ONE MEDICINE
//   // ------------------------------------------------

//   print('=== GET ONE MEDICINE ===');

//   final medicineResult = await getMedicineService.execute(medicineId: 'med_1');

//   switch (medicineResult) {
//     case OperationSuccess(:final data):
//       print('Medicine loaded: $data');

//     case OperationFailure(:final message):
//       print('Failed: $message');
//   }

//   // ------------------------------------------------
//   // GET ALL MEDICINES
//   // ------------------------------------------------

//   print('');
//   print('=== GET ALL MEDICINES ===');

//   final medicinesResult = await getMedicinesService.execute();

//   switch (medicinesResult) {
//     case OperationSuccess(:final data):
//       for (final medicine in data) {
//         print(medicine);
//       }

//     case OperationFailure(:final message):
//       print('Failed: $message');
//   }

//   // ------------------------------------------------
//   // REFILL SUMMARY
//   // ------------------------------------------------

//   print('');
//   print('=== REFILL SUMMARY ===');

//   final refillResult = await getRefillSummaryService.execute(
//     medicineId: 'med_1',
//   );

//   switch (refillResult) {
//     case OperationSuccess(:final data):
//       print('Medicine: ${data.medicineName}');
//       print('Days remaining: ${data.daysRemaining}');
//       print('Refill soon: ${data.refillSoon}');

//     case OperationFailure(:final message):
//       print('Failed: $message');
//   }

//   // ------------------------------------------------
//   // MISSING MEDICINE
//   // ------------------------------------------------

//   print('');
//   print('=== MISSING MEDICINE ===');

//   final missingResult = await getMedicineService.execute(medicineId: 'unknown');

//   switch (missingResult) {
//     case OperationSuccess(:final data):
//       print('Medicine loaded: $data');

//     case OperationFailure(:final message):
//       print('Failed: $message');
//   }
// }

Future<void> main() async {
  // --------------------------------------------------
  // 1. STRING EXTENSIONS
  // --------------------------------------------------

  print('=== STRING EXTENSIONS ===');

  final medicineName = '   vitamin D   ';

  print('Original: "$medicineName"');
  print('Normalized: "${medicineName.normalized}"');
  print('Is blank: ${medicineName.isBlank}');
  print('Capitalized: "${medicineName.capitalized}"');

  print('');

  // --------------------------------------------------
  // 2. ENHANCED ENUM - DOSE STATUS
  // --------------------------------------------------

  print('=== DOSE STATUS ENUM ===');

  final doseStatus = DoseStatus.missed;

  print('Status: ${doseStatus.label}');
  print('Requires attention: ${doseStatus.requiresAttention}');
  print('Is completed: ${doseStatus.isCompleted}');

  print('');

  // --------------------------------------------------
  // 3. ENHANCED ENUM - REMINDER CHANNEL
  // --------------------------------------------------

  print('=== REMINDER CHANNEL ===');

  final channel = ReminderChannel.whatsapp;

  print('Channel: ${channel.displayName}');
  print('Requires phone number: ${channel.requiresPhoneNumber}');

  print('');

  // --------------------------------------------------
  // 4. CALLBACKS
  // --------------------------------------------------

  print('=== REMINDER PROCESSOR ===');

  final processor = ReminderProcessor();

  processor.process(
    channel: ReminderChannel.whatsapp,
    recipient: '+919999999999',
    message: 'Time to take Vitamin D.',
    onSent: (sentChannel) {
      print(
        'Successfully sent through '
        '${sentChannel.displayName}',
      );
    },
    onFailed: (failedChannel, message) {
      print('${failedChannel.displayName} failed: $message');
    },
  );

  print('');

  // --------------------------------------------------
  // 5. REPOSITORY + SERVICE
  // --------------------------------------------------

  print('=== GET MEDICINE SERVICE ===');

  final repository = FakeMedicineRepository();

  final getMedicineService = GetMedicineService(repository: repository);

  final result = await getMedicineService.execute(medicineId: 'med_1');

  switch (result) {
    case OperationSuccess(:final data):
      print('Medicine loaded: $data');

    case OperationFailure(:final message):
      print('Failed: $message');
  }

  print('');

  // --------------------------------------------------
  // 6. OPERATION RESULT EXTENSION
  // --------------------------------------------------

  print('=== OPERATION RESULT EXTENSIONS ===');

  print('Is success: ${result.isSuccess}');
  print('Is failure: ${result.isFailure}');
  print('Data: ${result.dataOrNull}');
  print('Error message: ${result.errorMessageOrNull}');

  print('');

  // --------------------------------------------------
  // 7. MEDICINE LIST EXTENSION
  // --------------------------------------------------

  print('=== MEDICINE LIST EXTENSION ===');

  final medicinesResult = await repository.fetchMedicines();

  final outOfStockMedicines = medicinesResult.outOfStockMedicines;

  print('All medicines:');

  for (final medicine in medicinesResult) {
    print(medicine);
  }

  print('');

  print('Out-of-stock medicines:');

  if (outOfStockMedicines.isEmpty) {
    print('None');
  } else {
    for (final medicine in outOfStockMedicines) {
      print(medicine);
    }
  }

  print('');

  // --------------------------------------------------
  // 8. FAILURE RESULT EXAMPLE
  // --------------------------------------------------

  print('=== FAILURE RESULT ===');

  final failureResult = await getMedicineService.execute(medicineId: 'unknown');

  print('Is success: ${failureResult.isSuccess}');

  print('Is failure: ${failureResult.isFailure}');

  print('Error: ${failureResult.errorMessageOrNull}');

  print('');

  print('Day 3 Part 4 completed.');
}

//
