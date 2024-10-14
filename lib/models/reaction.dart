import '../cometchat_sdk.dart';

/// Represents a reaction within the chat.
///
/// This class includes properties that encapsulate details of a reaction,
/// including the id, messageId, reaction, uid, reactedAt time, and the user who reacted.
class Reaction {
  String? id;
  int? messageId;
  String? reaction;
  String? uid;
  int? reactedAt;
  User? reactedBy;

  /// Constructs a new `Reaction` instance.
  Reaction(
      {this.id,
      this.messageId,
      this.reaction,
      this.uid,
      this.reactedAt,
      this.reactedBy});

  /// Creates a new `Reaction` instance from a map.
  factory Reaction.fromMap(dynamic map) {
    if (map == null) {
      throw ArgumentError('The type of message reaction map is null');
    }
    return Reaction(
        id: map['id'] ?? '',
        messageId: map['messageId'] ?? null,
        reaction: map['reaction'],
        uid: map['uid'],
        reactedAt: map['reactedAt'],
        reactedBy:
            map['reactedBy'] != null ? User.fromMap(map['reactedBy']) : null);
  }

  /// Generates a map representing the `Reaction`.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['messageId'] = this.messageId;
    data['reaction'] = this.reaction;
    data['uid'] = this.uid;
    data['reactedAt'] = this.reactedAt;
    if (this.reactedBy != null) {
      data['reactedBy'] = this.reactedBy!.toJson();
    }
    return data;
  }

  /// Generates a string representation of the `Reaction`.
  @override
  String toString() {
    return """
    Reaction {
       id : $id,
       messageId : $messageId,
       reaction : $reaction,
       uid : $uid,
       reactedAt : $reactedAt,
       reactedBy : $reactedBy
    }
    """;
  }
}
