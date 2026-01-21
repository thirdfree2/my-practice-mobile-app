class CounterSummaryModel {
  final int count;
  final DateTime? updatedAt;

  const CounterSummaryModel({required this.count, this.updatedAt});

  factory CounterSummaryModel.fromJson(Map<String, dynamic> json) {
    // รองรับทั้งแบบ data: {...} และแบบแบน ๆ
    final data = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    final updatedAtRaw = data['updatedAt'];

    return CounterSummaryModel(
      count: _toInt(data['count']),
      updatedAt: updatedAtRaw is String
          ? DateTime.tryParse(updatedAtRaw)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'updatedAt': updatedAt?.toIso8601String(),
  };

  static int _toInt(dynamic v) {
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }
}
