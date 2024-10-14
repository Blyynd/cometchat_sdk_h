enum RepliesOptions {
  DONT_SUBSCRIBE(1),
  SUBSCRIBE_TO_ALL(2),
  SUBSCRIBE_TO_MENTIONS(3);

  final int value;

  const RepliesOptions(this.value);

  @override
  String toString() => value.toString();

  static RepliesOptions? fromValue(int value) {
    for (final option in RepliesOptions.values) {
      if (option.value == value) {
        return option;
      }
    }
    return null;
  }
}
