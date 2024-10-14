enum MutedConversationType {
  ONE_ON_ONE('oneOnOne'),
  GROUP('group');

  final String type;

  const MutedConversationType(this.type);

  @override
  String toString() => type.toString();

  static MutedConversationType? fromValue(String value) {
    for (final option in MutedConversationType.values) {
      if (option.type == value) {
        return option;
      }
    }
    return null;
  }
}
