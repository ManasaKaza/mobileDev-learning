import 'dart:async';

void demonstrateEventQueue() {
  print('A');

  Future<void>(() {
    print('Future');
  });

  print('B');
}

void demonstrateMicrotaskQueue() {
  print('A');

  Future<void>(() {
    print('Future');
  });

  scheduleMicrotask(() {
    print('Microtask');
  });

  print('B');
}

Future<void> demonstrateAwait() async {
  print('A');

  await Future<void>.delayed(const Duration(seconds: 1));

  print('B');
}

Future<void> demonstrateFutureStartBeforeAwait() async {
  print('A');

  final future = Future<void>.delayed(const Duration(seconds: 1), () {
    print('B');
  });

  print('C');

  await future;

  print('D');
}

Future<String> loadUser() async {
  await Future<void>.delayed(const Duration(seconds: 1));

  return 'Manasa';
}

Future<List<String>> loadMedicines() async {
  await Future<void>.delayed(const Duration(seconds: 1));

  return ['Vitamin D', 'Metformin'];
}

Future<void> demonstrateSequentialExecution() async {
  final user = await loadUser();

  final medicines = await loadMedicines();

  print('User: $user');
  print('Medicines: $medicines');
}

Future<void> demonstrateConcurrentExecution() async {
  final userFuture = loadUser();
  final medicinesFuture = loadMedicines();

  final user = await userFuture;
  final medicines = await medicinesFuture;

  print('User: $user');
  print('Medicines: $medicines');
}
