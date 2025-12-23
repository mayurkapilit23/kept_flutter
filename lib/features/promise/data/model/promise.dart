class Promise {
   String id;
   String text;
   String toName;
   String toPhone;
   DateTime createdAt;
   DateTime dueAt;

  final bool isDone;

  Promise({
    required this.id,
    required this.text,
    required this.toName,
    required this.toPhone,
    required this.createdAt,
    required this.dueAt,
    required this.isDone,
  });

  Promise copyWith({
    String? text,
    String? toName,
    String? toPhone,
    DateTime? dueAt,
    bool? isDone,
  }) {
    return Promise(
      id: id,
      text: text ?? this.text,
      toName: toName ?? this.toName,
      toPhone: toPhone ?? this.toPhone,
      createdAt: createdAt,
      dueAt: dueAt ?? this.dueAt,
      isDone: isDone ?? this.isDone,
    );
  }

  factory Promise.fromJson(Map<String, dynamic> json) {
    return Promise(
      id: json['id'],
      text: json['text'],
      toName: json['toName'],
      toPhone: json['toPhone'],
      createdAt: DateTime.parse(json['createdAt']),
      dueAt: DateTime.parse(json['dueAt']),
      isDone: json['isDone'],
    );
  }
}
