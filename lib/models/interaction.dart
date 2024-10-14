/// Represents an interaction within the chat.
///
/// This class includes properties that encapsulate details of an interaction,
/// including the elementId of the interacted element and the time of interaction.
class Interaction {
  String elementId;
  DateTime interactedAt;

  /// Constructs a new `Interaction` instance.
  ///
  /// Requires [elementId] and [interactedAt] to be specified.
  Interaction({required this.elementId, required this.interactedAt});

  /// Creates a new `Interaction` instance from a map.
  factory Interaction.fromMap(dynamic map) {
    return Interaction(
      elementId: map['elementId'],
      interactedAt: map['interactedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['interactedAt'] * 1000)
          : DateTime.now(),
    );
  }

  /// Generates a map representing the `Interaction`.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["elementId"] = elementId;
    map["interactedAt"] = interactedAt.millisecondsSinceEpoch;
    return map;
  }

  /// Generates a string representation of the `Interaction`.
  @override
  String toString() {
    return 'Interaction{elementId: $elementId, interactedAt: $interactedAt}';
  }
}
