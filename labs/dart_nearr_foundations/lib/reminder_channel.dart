enum ReminderChannel {
  push(displayName: 'Push notification', requiresPhoneNumber: false),

  whatsapp(displayName: 'WhatsApp', requiresPhoneNumber: true),

  sms(displayName: 'SMS', requiresPhoneNumber: true),

  voice(displayName: 'Voice call', requiresPhoneNumber: true);

  final String displayName;
  final bool requiresPhoneNumber;

  const ReminderChannel({
    required this.displayName,
    required this.requiresPhoneNumber,
  });
}
