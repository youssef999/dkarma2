class AlarmItem {
  String description, day;
  DateTime dateTime;
  String isActive;
  String isDeleted;
  String isRepeated;
  int id;

  AlarmItem(
      {this.description,
      this.id,
      isRepeated,
      this.day,
      this.dateTime,
      this.isActive,
      this.isDeleted});

  factory AlarmItem.fromJson(val) {
    return AlarmItem(
        isRepeated: val['isRepeated'],
        isActive: val['isActive'],
        isDeleted: val['isDeleted'],
        dateTime: DateTime.tryParse(val['dateTime']),
        day: val['day'],
        id: int.parse(val['id']),
        description: val['description']);
  }

  Map<String, String> toJsonObject() {
    return {
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'isActive': isActive ?? 'false',
      'isDeleted': isDeleted ?? 'false',
      'isRepeated': isRepeated ?? 'false',
      'day': day ?? '',
      'id': id.toString()
    };
  }
}
