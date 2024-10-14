import 'dart:io' show Platform;
import '../cometchat_sdk.dart';

/// Represents an interaction receipt within the chat.
///
/// This class includes properties that encapsulate details of an interaction receipt,
/// including the messageId, sender, receiverType, receiverId, and list of interactions.
class InteractionReceipt {
  int messageId;
  User sender;
  String receiverType;
  String receiverId;
  List<Interaction> interactions;

  /// Constructs a new `InteractionReceipt` instance.
  ///
  /// Requires [messageId], [sender], [receiverType], [receiverId], and [interactions] to be specified.
  InteractionReceipt(
      {required this.messageId,
      required this.sender,
      required this.receiverType,
      required this.receiverId,
      required this.interactions});

  /// Creates a new `InteractionReceipt` instance from a map.
  factory InteractionReceipt.fromMap(dynamic map) {
    late int messageId;
    if (Platform.isAndroid) {
      messageId = map['messageId'] ?? 0;
    } else if (Platform.isIOS) {
      messageId = int.parse(map['messageId'] ?? '0');
    } else {
      messageId = map['messageId'] ?? 0;
    }
    return InteractionReceipt(
      messageId: messageId,
      sender: User.fromMap(map['sender']),
      receiverType: map['receiverType'],
      receiverId: map['receiverId'],
      interactions: map['interactions'] != null
          ? (map['interactions'])
              .map<Interaction>((optionMap) => Interaction.fromMap(optionMap))
              .toList()
          : null,
    );
  }

  /// Generates a string representation of the `InteractionReceipt`.
  @override
  String toString() {
    return 'InteractionReceipt{messageId: $messageId, sender: $sender, receiverType: $receiverType, receiverId: $receiverId, interactions: $interactions}';
  }
}
