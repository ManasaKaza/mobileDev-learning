import 'package:dart_nearr_foundations/reminder_dispatcher.dart';
import 'package:dart_nearr_foundations/reminder_sender.dart';
import 'package:test/test.dart';

class RecordingReminderSender implements ReminderSender {
  @override
  String get channelName => 'recording';

  int sendCount = 0;
  String? lastRecipient;
  String? lastMessage;

  @override
  void send({required String recipient, required String message}) {
    sendCount++;

    lastRecipient = recipient;
    lastMessage = message;
  }
}

void main() {
  test('dispatcher sends the reminder through configured sender', () {
    final sender = RecordingReminderSender();

    final dispatcher = ReminderDispatcher(senders: [sender]);

    dispatcher.dispatch(recipient: 'amma', message: 'Take Vitamin D.');

    expect(sender.sendCount, 1);
    expect(sender.lastRecipient, 'amma');
    expect(sender.lastMessage, 'Take Vitamin D.');
  });

  test('dispatcher uses every configured sender', () {
    final first = RecordingReminderSender();
    final second = RecordingReminderSender();

    final dispatcher = ReminderDispatcher(senders: [first, second]);

    dispatcher.dispatch(recipient: 'amma', message: 'Take Vitamin D.');

    expect(first.sendCount, 1);
    expect(second.sendCount, 1);
  });

  test('rejects empty sender configuration', () {
    expect(() => ReminderDispatcher(senders: []), throwsArgumentError);
  });
}
