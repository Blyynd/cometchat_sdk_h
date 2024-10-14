/// Represents a count of reactions within the chat.
///
/// This class includes properties that encapsulate details of a reaction count,
/// including the reaction, count, and a flag indicating if the current user has reacted.
class ReactionCount {
  String? reaction;
  int? count;
  bool? reactedByMe;

  /// Constructs a new `ReactionCount` instance.
  ReactionCount({this.reaction, this.count, this.reactedByMe});

  /// Creates a new `ReactionCount` instance from a map.
  factory ReactionCount.fromMap(dynamic map) {
    if (map == null) {
      throw ArgumentError('The type of reaction map is null');
    }
    return ReactionCount(
        reaction: map['reaction'] ?? '',
        count: map['count'] ?? '',
        reactedByMe: map['reactedByMe'] ?? false);
  }

  /// Generates a map representing the `ReactionCount`.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reaction'] = this.reaction;
    data['count'] = this.count;
    data['reactedByMe'] = this.reactedByMe;
    return data;
  }

  /// Generates a string representation of the `ReactionCount`.
  @override
  String toString() {
    return """ReactionCount {reaction: $reaction, count: $count, reactedByMe: $reactedByMe}""";
  }
}
