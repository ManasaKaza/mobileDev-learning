// enum DoseStatus { missed, taken, pending }

enum DoseStatus {
  pending(label: 'Pending', requiresAttention: false),

  taken(label: 'Taken', requiresAttention: false),

  missed(label: 'Missed', requiresAttention: true);

  final String label;
  final bool requiresAttention;

  const DoseStatus({required this.label, required this.requiresAttention});

  bool get isCompleted {
    return this == DoseStatus.taken;
  }
}
