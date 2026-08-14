abstract interface class ReminderSender {
  String get channelName;

  void send({required String recipient, required String message});
}
