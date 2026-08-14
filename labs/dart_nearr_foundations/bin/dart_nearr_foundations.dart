import 'package:dart_nearr_foundations/immutable_medicine.dart';
import 'package:dart_nearr_foundations/push_reminder_sender.dart';
import 'package:dart_nearr_foundations/refill_calculator.dart';
import 'package:dart_nearr_foundations/refill_message.dart';
import 'package:dart_nearr_foundations/medicine_schedule.dart';
import 'package:dart_nearr_foundations/medicine_registry.dart';
import 'package:dart_nearr_foundations/medicine.dart';
import 'package:dart_nearr_foundations/reminder_dispatcher.dart';
import 'package:dart_nearr_foundations/sms_reminder_sender.dart';
import 'package:dart_nearr_foundations/whatsapp_reminder_sender.dart';

void main() {
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

  final dispatcher = ReminderDispatcher(
    senders: [
      PushReminderSender(),
      WhatsappReminderSender(),
      SmsReminderSender(),
    ],
  );

  print('Configured channels: ${dispatcher.channelNames}');

  dispatcher.dispatch(recipient: 'amma', message: 'Time to take Vitamin D.');
}
