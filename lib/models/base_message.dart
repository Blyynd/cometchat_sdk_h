import '../cometchat_sdk.dart';

/// Represents a basic chat message.
///
/// This class serves as a base class for more specific types of messages,
/// such as text messages, media messages, action messages, etc.
///
/// Each `BaseMessage` includes a variety of properties, including sender
/// information, receiver information, timestamps, and more. Among the
/// properties are some specifically designed for more advanced message
/// types, such as `unreadRepliesCount` for counting unread reply messages,
/// and `reactions` for storing reactions added to the message.
class BaseMessage extends AppEntity {
  int id;
  String muid;
  User? sender;
  AppEntity? receiver;
  String receiverUid;
  String type;
  String receiverType;
  String category;
  DateTime? sentAt;
  DateTime? deliveredAt;
  DateTime? readAt;
  Map<String, dynamic>? metadata;
  DateTime? readByMeAt;
  DateTime? deliveredToMeAt;
  DateTime? deletedAt;
  DateTime? editedAt;
  String? deletedBy;
  String? editedBy;
  DateTime? updatedAt;
  String? conversationId;
  int parentMessageId;
  int replyCount;
  List<User> mentionedUsers;
  bool? hasMentionedMe = false;
  List<ReactionCount> reactions;
  int unreadRepliesCount;
  bool? isLastMessageRead;
  bool? isLastMessageSent;

  /// Constructs a new `BaseMessage` instance.
  ///
  /// Most properties are optional and have default values. Some, such as
  /// `receiverUid`, `type`, and `receiverType` are required.
  BaseMessage(
      {this.id = 0,
      this.muid = '',
      this.sender,
      this.receiver,
      required this.receiverUid,
      required this.type,
      required this.receiverType,
      this.category = '',
      this.sentAt,
      this.deliveredAt,
      required this.readAt,
      this.metadata,
      this.readByMeAt,
      this.deliveredToMeAt,
      this.deletedAt,
      this.editedAt,
      this.deletedBy,
      this.editedBy,
      this.updatedAt,
      this.conversationId,
      this.parentMessageId = 0,
      this.replyCount = 0,
      this.unreadRepliesCount = 0,
      this.mentionedUsers = const [],
      this.reactions = const [],
      this.hasMentionedMe,
      this.isLastMessageRead,
      this.isLastMessageSent});

  /// Creates a new `BaseMessage` instance from a map.
  factory BaseMessage.fromMap(dynamic map) {
    if (map == null) {
      throw ArgumentError('The type of base message map is null');
    }
    final String category = map['category'] ?? '';
    if (category.isEmpty) {
      throw Exception('Category is missing in JSON');
    }
    if (category == CometChatMessageCategory.message) {
      if (map['type'] == 'text') {
        return TextMessage.fromMap(map);
      } else if (map['type'] == CometChatMessageType.file ||
          map['type'] == CometChatMessageType.image ||
          map['type'] == CometChatMessageType.video ||
          map['type'] == CometChatMessageType.audio) {
        return MediaMessage.fromMap(map);
      } else {
        throw UnimplementedError();
      }
    } else if (category == CometChatMessageCategory.action) {
      return Action.fromMap(map);
    } else if (category == CometChatMessageCategory.call) {
      return Call.fromMap(map);
    } else if (category == CometChatMessageCategory.custom) {
      return CustomMessage.fromMap(map);
    } else if (category == CometChatMessageCategory.interactive) {
      return InteractiveMessage.fromMap(map);
    } else {
      throw ArgumentError();
    }
  }

  /// Generates a map representing the `BaseMessage`.
  Map<String, dynamic> toJson() {
    User? userObj = sender;
    late Map receiverMap;
    if (receiverType == CometChatReceiverType.group) {
      Group grp = receiver as Group;
      receiverMap = grp.toJson();
    } else {
      User usr = receiver as User;
      receiverMap = usr.toJson();
    }
    final map = <String, dynamic>{};
    map['metadata'] = metadata;
    if (receiver != null) {
      map['receiver'] = receiverMap;
    }
    map['editedBy'] = editedBy;
    map['conversationId'] = conversationId;
    map['sentAt'] = sentAt == null ? 0 : sentAt?.millisecondsSinceEpoch;
    map['receiverUid'] = receiverUid;
    map['type'] = type;
    map['readAt'] = readAt == null ? 0 : readAt?.millisecondsSinceEpoch;
    map['deletedBy'] = deletedBy;
    map['deliveredAt'] =
        deliveredAt == null ? 0 : deliveredAt?.millisecondsSinceEpoch;
    map['muid'] = muid;
    map['deletedAt'] =
        deletedAt == null ? 0 : deletedAt?.millisecondsSinceEpoch;
    map['replyCount'] = replyCount;
    if (sender != null) {
      map['sender'] = userObj!.toJson();
    }
    map['receiverType'] = receiverType;
    map['editedAt'] = editedAt == null ? 0 : editedAt?.millisecondsSinceEpoch;
    map['parentMessageId'] = parentMessageId;
    map['readByMeAt'] =
        readByMeAt == null ? 0 : readByMeAt?.millisecondsSinceEpoch;
    map['id'] = id;
    map['category'] = category;
    map['deliveredToMeAt'] =
        deliveredToMeAt == null ? 0 : deliveredToMeAt?.millisecondsSinceEpoch;
    map['updatedAt'] =
        updatedAt != null ? updatedAt?.millisecondsSinceEpoch : 0;
    map['unreadRepliesCount'] = unreadRepliesCount;
    return map;
  }
}
