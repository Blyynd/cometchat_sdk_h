/// Represents an interaction goal within the chat.
///
/// This class includes properties that encapsulate details of an interaction goal,
/// including the type of goal and the elementIds associated with this goal.
class InteractionGoal {
  String type;
  List<String> elementIds;

  /// Constructs a new `InteractionGoal` instance.
  ///
  /// Requires [type] to be specified. [elementIds] is optional and defaults to an empty list.
  InteractionGoal({required this.type, this.elementIds = const []});

  /// Returns the list of element IDs associated with this interaction goal.
  List<String> getElementIds() {
    return elementIds;
  }

  /// Sets the list of element IDs associated with this interaction goal.
  void setElementIds(List<String> elementIds) {
    this.elementIds = elementIds;
  }

  /// Generates a map representing the `InteractionGoal`.
  Map<String, dynamic> toMap() {
    return {'type': type, 'elementIds': elementIds};
  }

  /// Creates a new `InteractionGoal` instance from a map.
  factory InteractionGoal.fromMap(dynamic map) {
    final String type = map?['type'] ?? "none";
    final List<String> elementIds = List<String>.from(map?['elementIds'] ?? []);
    return InteractionGoal(type: type, elementIds: elementIds);
  }

  /// Generates a string representation of the `InteractionGoal`.
  @override
  String toString() {
    return 'InteractionGoal{type: $type, elementIds: $elementIds}';
  }
}
