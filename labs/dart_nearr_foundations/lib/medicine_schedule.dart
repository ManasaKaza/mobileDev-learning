List<int> createDefaultReminderHours() {
  return [8, 14, 20];
}

void addReminderHour({required List<int> reminderHours, required int hour}) {
  if (hour < 0 || hour > 23) {
    throw ArgumentError.value(hour, 'hour', 'must be between 0 and 23');
  }

  if (reminderHours.contains(hour)) {
    return;
  }

  reminderHours.add(hour);
  reminderHours.sort();
}

bool removeReminderHour({required List<int> reminderHours, required int hour}) {
  return reminderHours.remove(hour);
}

// List<String> buildReminderLabels(List<int> reminderHours) {
//   final labels = <String>[];

//   for (final hour in reminderHours) {
//     labels.add('$hour:00');
//   }

//   return labels;
// }

List<String> buildReminderLabels(List<int> reminderHours) {
  return reminderHours.map((hour) => '$hour:00').toList();
}

// int countMorningReminders(List<int> reminderHours) {
//   var count = 0;

//   for (final hour in reminderHours) {
//     if (hour < 12) {
//       count++;
//     }
//   }

//   return count;
// }

int countMorningReminders(List<int> reminderHours) {
  return reminderHours.where((hour) => hour < 12).length;
}

bool hasEveningReminders(List<int> reminderHours) {
  return reminderHours.any((hour) => hour >= 18);
}

bool areAllRemindersValid(List<int> reminderHours) {
  return reminderHours.every((hour) => hour >= 0 && hour <= 23);
}
