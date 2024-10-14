import '../../cometchat_sdk.dart';

class MutePreferences {
  DNDOptions? dnd;
  Map<DayOfWeek, DaySchedule>? schedule = <DayOfWeek, DaySchedule>{};

  MutePreferences({this.dnd, this.schedule});

  MutePreferences.fromMap(dynamic map) {
    dnd = DNDOptions.fromValue(map['dnd']);
    if (map['schedule'] != null) {
      final scheduleMap = map['schedule'];
      for (final key in scheduleMap.keys) {
        if (schedule != null) {
          schedule![DayOfWeek.fromValue(key)!] =
              DaySchedule.fromMap(scheduleMap[key]);
        }
      }
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dnd'] = dnd?.value;
    if (schedule != null) {
      Map<String, dynamic> map = <String, dynamic>{};
      for (final k in schedule!.keys) {
        map[k.dayName] = schedule![k]!.toMap();
      }
      if (map.isNotEmpty) data['schedule'] = map;
    }
    return data;
  }
}
