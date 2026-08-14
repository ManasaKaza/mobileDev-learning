import 'reminder_sender.dart';

abstract class BaseReminderSender implements ReminderSender {
  void validateReminder({required String recipient, required String message}) {
    if (recipient.trim().isEmpty) {
      throw ArgumentError('Recipient cannot be empty.');
    }

    if (message.trim().isEmpty) {
      throw ArgumentError('Reminder message cannot be empty.');
    }
  }
}
