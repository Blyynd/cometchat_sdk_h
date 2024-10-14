enum MemberActionsOptions {
  DONT_SUBSCRIBE(1),
  SUBSCRIBE(2);

  final int value;

  const MemberActionsOptions(this.value);

  @override
  String toString() => value.toString();

  static MemberActionsOptions? fromValue(int value) {
    for (final option in MemberActionsOptions.values) {
      if (option.value == value) {
        return option;
      }
    }
    return null;
  }
}
