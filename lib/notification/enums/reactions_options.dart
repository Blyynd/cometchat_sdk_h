enum ReactionsOptions {
  DONT_SUBSCRIBE(1),
  SUBSCRIBE_TO_REACTIONS_ON_OWN_MESSAGES(2),
  SUBSCRIBE_TO_REACTIONS_ON_ALL_MESSAGES(3);

  final int value;

  const ReactionsOptions(this.value);

  @override
  String toString() => value.toString();

  static ReactionsOptions? fromValue(int value) {
    for (final option in ReactionsOptions.values) {
      if (option.value == value) {
        return option;
      }
    }
    return null;
  }
}
