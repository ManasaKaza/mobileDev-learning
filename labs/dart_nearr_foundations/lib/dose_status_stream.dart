// Stream<String> doseStatusUpdates() async* {
//   yield 'pending';

//   await Future<void>.delayed(const Duration(seconds: 1));

//   yield 'taken';
// }

// // try {
// //   await for (final status in doseStatusUpdates()) {
// //     print(status);
// //   }
// // } catch (error) {
// //   print('Stream failed: $error');
// // }

// Stream<int> reminderCountdown({required int seconds}) async* {
//   if (seconds < 0) {
//     throw ArgumentError.value(seconds, 'seconds', 'cannot be negative');
//   }

//   for (var remaining = seconds; remaining >= 0; remaining--) {
//     yield remaining;

//     if (remaining > 0) {
//       await Future<void>.delayed(const Duration(seconds: 1));
//     }
//   }
// }

Stream<String> doseStatusUpdates({
  Duration delay = const Duration(seconds: 1),
}) async* {
  yield 'pending';

  await Future<void>.delayed(delay);

  yield 'taken';
}

Stream<int> reminderCountdown({
  required int seconds,
  Duration interval = const Duration(seconds: 1),
}) async* {
  if (seconds < 0) {
    throw ArgumentError.value(seconds, 'seconds', 'cannot be negative');
  }

  for (var remaining = seconds; remaining >= 0; remaining--) {
    yield remaining;

    if (remaining > 0) {
      await Future<void>.delayed(interval);
    }
  }
}

Stream<int> stockUpdates({
  int startingStock = 3,
  Duration interval = const Duration(milliseconds: 500),
}) async* {
  if (startingStock < 0) {
    throw ArgumentError.value(
      startingStock,
      'startingStock',
      'cannot be negative',
    );
  }

  for (var stock = startingStock; stock >= 0; stock--) {
    yield stock;

    if (stock > 0) {
      await Future<void>.delayed(interval);
    }
  }
}
