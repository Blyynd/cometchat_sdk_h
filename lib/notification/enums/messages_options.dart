enum MessagesOptions {
  DONT_SUBSCRIBE(1),
  SUBSCRIBE_TO_ALL(2),
  SUBSCRIBE_TO_MENTIONS(3);

  final int value;

  const MessagesOptions(this.value);

  @override
  String toString() => value.toString();

  static MessagesOptions? fromValue(int value) {
    for (final option in MessagesOptions.values) {
      if (option.value == value) {
        return option;
      }
    }
    return null;
  }
}
