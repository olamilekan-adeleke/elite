class TerminalModel {
  TerminalModel({
    required this.name,
    required this.id,
    required this.queueNumber,
    required this.todayCount,
  });

  factory TerminalModel.fromMap(Map<String, dynamic> map) {
    final DateTime now = DateTime.now();

    final String todayData = '${now.year}-${now.month}-${now.day}';

    return TerminalModel(
      id: map['id'] as String,
      name: (map['name'] ?? '') as String,
      queueNumber: (map['queue_number'] ?? 0) as int,
      todayCount: (map[todayData] ?? 0) as int,
    );
  }

  final String name;
  final String id;
  final int queueNumber;
  final int todayCount;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'queueNumber': queueNumber,
      'todayCount': todayCount,
    };
  }

  @override
  String toString() {
    return 'TerminalModel(name: $name, id: $id, queueNumber: '
        '$queueNumber, todayCount: $todayCount)';
  }
}
