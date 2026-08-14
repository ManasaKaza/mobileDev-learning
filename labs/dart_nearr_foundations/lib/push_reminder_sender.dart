import 'base_reminder_sender.dart';

class PushReminderSender extends BaseReminderSender {
  @override
  String get channelName => 'push';

  @override
  void send({required String recipient, required String message}) {
    validateReminder(recipient: recipient, message: message);

    print('[PUSH] Sending to $recipient: $message');
  }
}
