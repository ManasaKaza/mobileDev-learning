int consumeTablet({required int currentStock}) {
  if (currentStock <= 0) {
    throw StateError('Cannot consume a tablet when stock is empty.');
  }

  return currentStock - 1;
}
