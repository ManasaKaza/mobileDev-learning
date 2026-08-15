void deliverReminder({
  required String message,
  required void Function(String message) onDelivered,
}) {
  print('Delivering reminder...');

  onDelivered(message);
}
