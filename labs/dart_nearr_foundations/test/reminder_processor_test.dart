import 'package:dart_nearr_foundations/reminder_channel.dart';
import 'package:dart_nearr_foundations/reminder_processor.dart';
import 'package:test/test.dart';

void main() {
  group('ReminderProcessor', () {
    test('calls success callback', () {
      final processor = ReminderProcessor();

      ReminderChannel? sentChannel;

      processor.process(
        channel: ReminderChannel.whatsapp,
        recipient: '+919999999999',
        message: 'Take Vitamin D',
        onSent: (channel) {
          sentChannel = channel;
        },
        onFailed: (_, __) {},
      );

      expect(sentChannel, ReminderChannel.whatsapp);
    });

    test('calls failure callback when recipient is blank', () {
      final processor = ReminderProcessor();

      String? failureMessage;

      processor.process(
        channel: ReminderChannel.sms,
        recipient: ' ',
        message: 'Take Vitamin D',
        onSent: (_) {},
        onFailed: (_, message) {
          failureMessage = message;
        },
      );

      expect(failureMessage, 'Recipient cannot be empty.');
    });
  });
}
