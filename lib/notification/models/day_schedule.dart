class DaySchedule {
  int? from;
  int? to;
  bool? dnd;

  DaySchedule({this.from, this.to, this.dnd});

  DaySchedule.fromMap(dynamic map) {
    from = map['from'];
    to = map['to'];
    dnd = map['dnd'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (from != null) {
      data['from'] = from;
    }
    if (to != null) {
      data['to'] = to;
    }
    if (dnd != null) {
      data['dnd'] = dnd;
    }
    return data;
  }
}
