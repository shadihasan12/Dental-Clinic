class Payment {
  final String id;
  final double amount;
  final String? notes;
  final String caseId;
  final DateTime createdAt;

  const Payment({
    required this.id,
    required this.amount,
    this.notes,
    required this.caseId,
    required this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      notes: json['notes'] as String?,
      caseId: json['case_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
