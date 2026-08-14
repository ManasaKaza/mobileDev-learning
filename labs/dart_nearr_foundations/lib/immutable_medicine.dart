const _notProvided = Object();

class ImmutableMedicine {
  final String name;
  final int remainingTablets;
  final List<int> reminderHours;
  final String? note;

  ImmutableMedicine({
    required this.name,
    required this.remainingTablets,
    required List<int> reminderHours,
    this.note,
  }) : reminderHours = List<int>.unmodifiable(
         List<int>.from(reminderHours)..sort(),
       ) {
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'cannot be empty');
    }

    if (remainingTablets < 0) {
      throw ArgumentError.value(
        remainingTablets,
        'remainingTablets',
        'cannot be negative',
      );
    }

    for (final hour in reminderHours) {
      if (hour < 0 || hour > 23) {
        throw ArgumentError.value(
          hour,
          'reminderHours',
          'every hour must be between 0 and 23',
        );
      }
    }

    if (this.reminderHours.toSet().length != this.reminderHours.length) {
      throw ArgumentError.value(
        reminderHours,
        'reminderHours',
        'cannot contain duplicate hours',
      );
    }
  }

  ImmutableMedicine copyWith({
    String? name,
    int? remainingTablets,
    List<int>? reminderHours,
    Object? note = _notProvided,
  }) {
    return ImmutableMedicine(
      name: name ?? this.name,
      remainingTablets: remainingTablets ?? this.remainingTablets,
      reminderHours: reminderHours ?? this.reminderHours,
      note: identical(note, _notProvided) ? this.note : note as String?,
    );
  }

  ImmutableMedicine.empty({required String name, String? note})
    : this(
        name: name,
        remainingTablets: 0,
        reminderHours: const [],
        note: note,
      );

  ImmutableMedicine recordDoseTaken() {
    if (remainingTablets <= 0) {
      throw StateError('Cannot record a dose when stock is empty.');
    }

    return copyWith(remainingTablets: remainingTablets - 1);
  }

  ImmutableMedicine addReminderHour(int hour) {
    if (hour < 0 || hour > 23) {
      throw ArgumentError.value(hour, 'hour', 'must be between 0 and 23');
    }

    if (reminderHours.contains(hour)) {
      return this;
    }

    return copyWith(reminderHours: [...reminderHours, hour]);
  }

  ImmutableMedicine removeReminderHour(int hour) {
    if (!reminderHours.contains(hour)) {
      return this;
    }

    final updatedHours = reminderHours
        .where((existingHour) => existingHour != hour)
        .toList();

    return copyWith(reminderHours: updatedHours);
  }

  bool get isOutOfStock => remainingTablets <= 0;

  int get dailyReminderCount => reminderHours.length;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ImmutableMedicine &&
            other.name == name &&
            other.remainingTablets == remainingTablets &&
            other.note == note &&
            _listsEqual(other.reminderHours, reminderHours);
  }

  bool _listsEqual(List<int> first, List<int> second) {
    if (first.length != second.length) return false;

    for (var i = 0; i < first.length; i++) {
      if (first[i] != second[i]) return false;
    }

    return true;
  }

  @override
  int get hashCode =>
      Object.hash(name, remainingTablets, note, Object.hashAll(reminderHours));
}
