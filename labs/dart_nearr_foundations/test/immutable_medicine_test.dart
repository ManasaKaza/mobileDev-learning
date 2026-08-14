import 'package:dart_nearr_foundations/immutable_medicine.dart';
import 'package:test/test.dart';

void main() {
  test('creates an immutable medicine', () {
    final medicine = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
    );

    expect(medicine.name, 'Vitamin D');
    expect(medicine.remainingTablets, 14);
    expect(medicine.reminderHours, [8, 20]);
  });

  test('reminder hours cannot be modified', () {
    final medicine = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
    );

    expect(() => medicine.reminderHours.add(14), throwsUnsupportedError);
  });

  test('copyWith changes only selected fields', () {
    final original = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
      note: 'After breakfast',
    );

    final updated = original.copyWith(remainingTablets: 13);

    expect(original.remainingTablets, 14);
    expect(updated.remainingTablets, 13);

    expect(updated.name, 'Vitamin D');
    expect(updated.reminderHours, [8, 20]);
    expect(updated.note, 'After breakfast');
  });

  test('copyWith creates a truly new instance', () {
    final original = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
    );

    final updated = original.copyWith(remainingTablets: 13);

    expect(identical(original, updated), false);
  });

  test('copyWith preserves unmodifiable list', () {
    final original = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
    );

    final updated = original.copyWith(
      remainingTablets: 13,
      reminderHours: [9, 21],
    );

    expect(updated.reminderHours, [9, 21]);
    expect(() => updated.reminderHours.add(10), throwsUnsupportedError);
  });

  test('copyWith works with null values', () {
    final original = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
      note: 'After breakfast',
    );

    final updated = original.copyWith(note: null);

    expect(updated.note, null);
    expect(original.note, 'After breakfast');
  });

  test('copyWith creates equal objects when all fields are same', () {
    final original = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
      note: 'After breakfast',
    );

    final copy = original.copyWith(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
      note: 'After breakfast',
    );

    expect(original, copy);
  });

  test('copyWith can explicitly clear the note', () {
    final original = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8],
      note: 'After breakfast',
    );

    final updated = original.copyWith(note: null);

    expect(original.note, 'After breakfast');
    expect(updated.note, isNull);
  });

  test('copyWith does not clear the note when not specified', () {
    final original = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8],
      note: 'After breakfast',
    );

    final updated = original.copyWith(name: 'Vitamin E');

    expect(updated.name, 'Vitamin E');
    expect(updated.note, 'After breakfast');
  });

  test('copyWith preserves equality when all arguments same', () {
    final original = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
      note: 'After breakfast',
    );

    final copy = original.copyWith(
      name: original.name,
      remainingTablets: original.remainingTablets,
      reminderHours: original.reminderHours,
      note: original.note,
    );

    expect(original, copy);
    expect(identical(original, copy), false);
  });

  test('medicines with the same values are equal', () {
    final first = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
    );

    final second = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 20],
    );

    expect(first, second);
  });

  test('medicines with different stock are not equal', () {
    final first = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8],
    );

    final second = first.copyWith(remainingTablets: 13);

    expect(first == second, isFalse);
  });

  test('removes reminder without modifying original medicine', () {
    final original = ImmutableMedicine(
      name: 'Vitamin D',
      remainingTablets: 14,
      reminderHours: [8, 14, 20],
    );

    final updated = original.removeReminderHour(14);

    expect(original.reminderHours, [8, 14, 20]);
    expect(updated.reminderHours, [8, 20]);
  });
}
