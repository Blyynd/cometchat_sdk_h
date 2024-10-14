import 'dart:io' show Platform;
import '../cometchat_sdk.dart';

/// Represents a message receipt within the chat.
///
/// This class includes properties that encapsulate details of a message receipt,
/// including the messageId, sender, receiverType, receiverId, timestamp, receiptType,
/// deliveredAt time, and readAt time.
class MessageReceipt {
  int messageId;
  User sender;
  String receiverType;
  String receiverId;
  DateTime timestamp;
  String receiptType;
  DateTime? deliveredAt;
  DateTime? readAt;

  /// Constructs a new `MessageReceipt` instance.
  ///
  /// Requires [messageId], [sender], [receiverType], [receiverId], [timestamp],
  /// [receiptType], [deliveredAt], and [readAt] to be specified.
  MessageReceipt(
      {required this.messageId,
      required this.sender,
      required this.receiverType,
      required this.receiverId,
      required this.timestamp,
      required this.receiptType,
      required this.deliveredAt,
      required this.readAt});

  /// Creates a new `MessageReceipt` instance from a map.
  factory MessageReceipt.fromMap(dynamic map) {
    late int messageId;
    DateTime? deliveredAt;
    DateTime? readAt;
    if (Platform.isAndroid) {
      messageId = map['messageId'] ?? 0;
      deliveredAt = map['deliveredAt'] == 0 || map['deliveredAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deliveredAt'] * 1000);
      readAt = map['readAt'] == 0 || map['readAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['readAt'] * 1000);
    } else if (Platform.isIOS) {
      messageId = int.parse(map['messageId'] ?? '0');
      deliveredAt = map['deliveredAt'] == 0 || map['deliveredAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              (map['deliveredAt'] * 1000).toInt());
      readAt = map['readAt'] == 0 || map['readAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch((map['readAt'] * 1000).toInt());
    } else {
      messageId = map['messageId'] ?? 0;
    }
    return MessageReceipt(
      messageId: messageId,
      sender: User.fromMap(map['sender']),
      receiverType: map['receivertype'],
      receiptType: map['receiptType'],
      timestamp: map['timestamp'] == 0
          ? DateTime.fromMillisecondsSinceEpoch(0)
          : DateTime.fromMillisecondsSinceEpoch(map['timestamp'] * 1000),
      deliveredAt: deliveredAt,
      readAt: readAt,
      receiverId: map['receiverId'],
    );
  }

  /// Generates a string representation of the `MessageReceipt`.
  @override
  String toString() {
    return 'MessageReceipt{messageId: $messageId, sender: $sender, receivertype: $receiverType, receiverId: $receiverId, timestamp: $timestamp, receiptType: $receiptType, deliveredAt: $deliveredAt, readAt: $readAt}';
  }
}
