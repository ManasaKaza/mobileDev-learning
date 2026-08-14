import 'package:dart_nearr_foundations/base_reminder_sender.dart';

class WhatsappReminderSender extends BaseReminderSender {
  @override
  String get channelName => 'whatsapp';

  @override
  void send({required String recipient, required String message}) {
    validateReminder(recipient: recipient, message: message);

    print('[WHATSAPP] Sending to $recipient: $message');
  }
}
