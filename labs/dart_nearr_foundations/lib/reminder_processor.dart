import 'reminder_channel.dart';

typedef ReminderSentCallback = void Function(ReminderChannel channel);

typedef ReminderFailedCallback =
    void Function(ReminderChannel channel, String message);

class ReminderProcessor {
  void process({
    required ReminderChannel channel,
    required String recipient,
    required String message,
    required ReminderSentCallback onSent,
    required ReminderFailedCallback onFailed,
  }) {
    if (recipient.trim().isEmpty) {
      onFailed(channel, 'Recipient cannot be empty.');

      return;
    }

    if (message.trim().isEmpty) {
      onFailed(channel, 'Message cannot be empty.');

      return;
    }

    print('Sending through ${channel.displayName}...');

    onSent(channel);
  }
}
