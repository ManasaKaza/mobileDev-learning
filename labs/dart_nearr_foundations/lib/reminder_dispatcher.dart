import 'reminder_sender.dart';

class ReminderDispatcher {
  final List<ReminderSender> _senders;

  ReminderDispatcher({required List<ReminderSender> senders})
    : _senders = List<ReminderSender>.unmodifiable(senders) {
    if (_senders.isEmpty) {
      throw ArgumentError('At least one reminder sender is required');
    }
  }

  List<String> get channelNames {
    return _senders.map((sender) => sender.channelName).toList();
  }

  void dispatch({required String recipient, required String message}) {
    for (final sender in _senders) {
      sender.send(recipient: recipient, message: message);
    }
  }
}
