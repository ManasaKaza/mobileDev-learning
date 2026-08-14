class Medicine {
  String name;
  String? note;

  int _remainingTablets;
  final List<int> _reminderHours;

  Medicine({
    required this.name,
    required int remainingTablets,
    required List<int> reminderHours,
    this.note,
  }) : _reminderHours = List<int>.from(reminderHours),
       _remainingTablets = remainingTablets {
    // ':' is the constructor initializer list and runs before the constructor body.
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'cannot be empty');
    }

    if (remainingTablets < 0) {
      throw ArgumentError.value(
        remainingTablets,
        'remaining tablets',
        'cannot be negative',
      );
    }

    for (final hour in _reminderHours) {
      if (hour < 0 || hour > 23) {
        throw ArgumentError.value(
          hour,
          'reminder hours',
          'every hour must be between 0 and 23',
        );
      }
    }

    if (_reminderHours.toSet().length != _reminderHours.length) {
      throw ArgumentError.value(
        _reminderHours,
        'reminderHours',
        'cannot contain duplicate hours',
      );
    }
    _reminderHours.sort();
  }

  List<int> get reminderHours => List<int>.unmodifiable(_reminderHours);
  int get remainingTablets => _remainingTablets;

  int calculateDailyTabletUsage() {
    return _reminderHours.length;
  }

  int estimateFullDaysRemaining() {
    final dailyUsage = calculateDailyTabletUsage();

    if (dailyUsage == 0) {
      return 0;
    }

    return remainingTablets ~/ dailyUsage;
  }

  void recordDoseTaken() {
    if (_remainingTablets <= 0) {
      throw StateError('Cannot record a dose when stock is empty');
    }
    _remainingTablets--;
  }

  void addRemainderHour(int hour) {
    if (hour < 0 || hour > 23) {
      throw ArgumentError.value(hour, 'hour', 'must be between 0 and 23');
    }

    if (_reminderHours.contains(hour)) {
      return;
    }

    _reminderHours.add(hour);
    _reminderHours.sort();
  }

  bool removeReminderHour(int hour) {
    return _reminderHours.remove(hour);
  }

  bool get isOutOfStock => remainingTablets == 0;

  int? get nextReminderHour {
    if (_reminderHours.isEmpty) return null;

    return _reminderHours[0];
  }
}
