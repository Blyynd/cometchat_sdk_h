enum DayOfWeek {
  MONDAY("monday"),
  TUESDAY("tuesday"),
  WEDNESDAY("wednesday"),
  THURSDAY("thursday"),
  FRIDAY("friday"),
  SATURDAY("saturday"),
  SUNDAY("sunday");

  final String dayName;

  const DayOfWeek(this.dayName);

  @override
  String toString() => dayName;

  static DayOfWeek? fromValue(String value) {
    for (final option in DayOfWeek.values) {
      if (option.dayName == value) {
        return option;
      }
    }
    return null;
  }
}
