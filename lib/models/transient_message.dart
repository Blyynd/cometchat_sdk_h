import '../cometchat_sdk.dart';

/// Represents a temporary or transient message within the chat.
///
/// This class includes properties that encapsulate details of a non-persistent chat message,
/// including the receiverId, receiverType, data, and sender.
class TransientMessage {
  String receiverId;
  String receiverType;
  Map<String, dynamic> data;
  User? sender;

  /// Constructs a new `TransientMessage` instance.
  ///
  /// Requires [receiverId], [receiverType], [data] to be specified. [sender] is optional.
  TransientMessage({
    required this.receiverId,
    required this.receiverType,
    required this.data,
    this.sender,
  });

  /// Generates a map representing the `TransientMessage`.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['receiverId'] = receiverId;
    map['receiverType'] = receiverType;
    map['data'] = data;
    if (sender != null) {
      map['sender'] = sender!.toJson();
    }
    return map;
  }

  /// Creates a new `TransientMessage` instance from a map.
  factory TransientMessage.fromMap(dynamic map) {
    return TransientMessage(
      receiverId: map['receiverId'],
      receiverType: map['receiverType'],
      data: Map<String, dynamic>.from(map['data'] ?? '{}'),
      sender: map['sender'] == null ? null : User.fromMap(map['sender']),
    );
  }

  /// Generates a string representation of the `TransientMessage`.
  @override
  String toString() {
    return 'TransientMessage{receiverId: $receiverId, receiverType: $receiverType, data: $data , sender $sender}';
  }
}
