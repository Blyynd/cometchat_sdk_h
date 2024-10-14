import 'dart:convert';
import '../cometchat_sdk.dart';

/// Represents a text message within the chat.
///
/// This class extends [BaseMessage] and adds additional properties
/// specifically related to a text message, such as the text and tags.
class TextMessage extends BaseMessage {
  String text;
  List<String>? tags;

  /// Constructs a new `TextMessage` instance.
  TextMessage(
      {required this.text,
      this.tags,
      int? id,
      String? muid,
      User? sender,
      AppEntity? receiver,
      required String receiverUid,
      required String type,
      required String receiverType,
      String? category,
      DateTime? sentAt,
      DateTime? deliveredAt,
      DateTime? readAt,
      Map<String, dynamic>? metadata,
      DateTime? readByMeAt,
      DateTime? deliveredToMeAt,
      DateTime? deletedAt,
      DateTime? editedAt,
      String? deletedBy,
      String? editedBy,
      DateTime? updatedAt,
      String? conversationId,
      int? parentMessageId,
      int? replyCount,
      int? unreadRepliesCount,
      List<User>? mentionedUsers,
      bool? hasMentionedMe,
      List<ReactionCount>? reactions})
      : super(
            id: id ?? 0,
            muid: muid ?? '',
            sender: sender,
            receiver: receiver,
            receiverUid: receiverUid,
            type: type,
            receiverType: receiverType,
            category: category ?? '',
            sentAt: sentAt,
            deliveredAt: deliveredAt,
            readAt: readAt,
            metadata: metadata,
            readByMeAt: readByMeAt,
            deliveredToMeAt: deliveredToMeAt,
            deletedAt: deletedAt,
            editedAt: editedAt,
            deletedBy: deletedBy,
            editedBy: editedBy,
            updatedAt: updatedAt,
            conversationId: conversationId,
            parentMessageId: parentMessageId ?? -1,
            replyCount: replyCount ?? 0,
            unreadRepliesCount: unreadRepliesCount ?? 0,
            mentionedUsers: mentionedUsers ?? [],
            reactions: reactions ?? [],
            hasMentionedMe: hasMentionedMe);

  /// Creates a new `TextMessage` instance from a map.
  factory TextMessage.fromMap(dynamic map, {AppEntity? receiver}) {
    if (map == null) {
      throw ArgumentError('The type of text message map is null');
    }
    final appEntity = (map['receiver'] == null)
        ? receiver
        : (map['receiverType'] == 'user')
            ? User.fromMap(map['receiver'])
            : Group.fromMap(map['receiver']);

    final conversationId = map['conversationId'].isEmpty
        ? map['receiverType'] == 'user'
            ? '${map['sender']['uid']}_user_${(appEntity as User).uid}'
            : 'group_${map['receiver']['guid']}'
        : map['conversationId'];

    TextMessage message = TextMessage(
      text: map['text'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      id: map['id'],
      muid: map['muid'],
      sender: map['sender'] == null ? null : User.fromMap(map['sender']),
      receiver: appEntity,
      receiverUid: map['receiverUid'],
      type: map['type'],
      receiverType: map['receiverType'],
      category: map['category'],
      sentAt: map['sentAt'] == 0 || map['sentAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['sentAt'] * 1000),
      deliveredAt: map['deliveredAt'] == 0 || map['deliveredAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deliveredAt'] * 1000),
      readAt: map['readAt'] == 0 || map['readAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['readAt'] * 1000),
      metadata: Map<String, dynamic>.from(json.decode(map['metadata'] ?? '{}')),
      readByMeAt: map['readByMeAt'] == 0 || map['readByMeAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['readByMeAt'] * 1000),
      deliveredToMeAt: map['deliveredToMeAt'] == 0 ||
              map['deliveredToMeAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deliveredToMeAt'] * 1000),
      deletedAt: map['deletedAt'] == 0 || map['deletedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] * 1000),
      editedAt: map['editedAt'] == 0 || map['editedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['editedAt'] * 1000),
      deletedBy: map['deletedBy'],
      editedBy: map['editedBy'],
      updatedAt: map['updatedAt'] == 0 || map['updatedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] * 1000),
      conversationId: conversationId,
      parentMessageId: map['parentMessageId'],
      replyCount: map['replyCount'],
      unreadRepliesCount: map['unreadRepliesCount'],
      mentionedUsers:
          map['mentionedUsers']?.map<User>((e) => User.fromMap(e)).toList() ??
              [],
      hasMentionedMe: map['hasMentionedMe'] ?? false,
      reactions: map['reactions']
              ?.map<ReactionCount>((e) => ReactionCount.fromMap(e))
              .toList() ??
          [],
    );

    return message;
  }

  /// Generates a map representing the `TextMessage`.
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
        updatedAt == null ? 0 : updatedAt?.millisecondsSinceEpoch;
    map['text'] = text;
    map['tags'] = tags;
    map['unreadRepliesCount'] = unreadRepliesCount;
    map['mentionedUsers'] = mentionedUsers.map((e) => e.toJson()).toList();
    map['hasMentionedMe'] = hasMentionedMe;
    map['reactions'] = reactions.map((e) => e.toJson()).toList();
    return map;
  }

  /// Generates a string representation of the `TextMessage`.
  @override
  String toString() {
    return 'TextMessage{id:  $id , text: $text, tags: $tags}';
  }
}
