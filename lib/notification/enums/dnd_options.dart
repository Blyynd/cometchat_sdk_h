enum DNDOptions {
  DISABLED(1),
  ENABLED(2);

  final int value;

  const DNDOptions(this.value);

  @override
  String toString() => value.toString();

  static DNDOptions? fromValue(int value) {
    for (final option in DNDOptions.values) {
      if (option.value == value) {
        return option;
      }
    }
    return null;
  }
}
