import '../cometchat_sdk.dart';

/// Represents a typing indicator within the chat.
///
/// This class includes properties that encapsulate details of a typing indicator,
/// including the sender, receiverId, receiverType, metadata, and the last timestamp.
class TypingIndicator {
  User sender;
  String receiverId;
  String receiverType;
  Map<String, String>? metadata;
  DateTime lastTimestamp;

  /// Constructs a new `TypingIndicator` instance.
  ///
  /// Requires [sender], [receiverId], [receiverType], and [lastTimestamp] to be specified. [metadata] is optional.
  TypingIndicator({
    required this.sender,
    required this.receiverId,
    required this.receiverType,
    this.metadata,
    required this.lastTimestamp,
  });

  /// Creates a new `TypingIndicator` instance from a map.
  factory TypingIndicator.fromMap(dynamic map) {
    return TypingIndicator(
      sender: User.fromMap(map['sender']),
      receiverId: map['receiverId'],
      receiverType: map['receiverType'],
      metadata: map['metadata'],
      lastTimestamp:
          DateTime.fromMillisecondsSinceEpoch(map['lastTimestamp'] ?? 0 * 1000),
    );
  }

  /// Generates a string representation of the `TypingIndicator`.
  @override
  String toString() {
    return 'TypingIndicator{sender: $sender, receiverId: $receiverId, receiverType: $receiverType, metadata: $metadata, lastTimestamp: $lastTimestamp}';
  }
}
