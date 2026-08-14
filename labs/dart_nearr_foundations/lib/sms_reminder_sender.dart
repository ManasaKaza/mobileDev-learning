import 'base_reminder_sender.dart';

class SmsReminderSender extends BaseReminderSender {
  @override
  final String channelName = 'sms';

  @override
  void send({required String recipient, required String message}) {
    validateReminder(recipient: recipient, message: message);

    print('[SMS] Sending SMS to $recipient: $message');
  }
}
