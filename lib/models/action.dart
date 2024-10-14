import 'dart:convert';
import '../cometchat_sdk.dart';

/// This class represents an action performed in the chat.
///
/// It extends [BaseMessage] and includes additional properties related to the action.
class Action extends BaseMessage {
  /// The message associated with the action.
  String? message;

  /// The raw data of the action.
  String? rawData;

  /// The type of the action.
  String? action;

  /// The old scope of the action.
  String? oldScope;

  /// The new scope of the action.
  String? newScope;

  /// The entity by whom the action was performed.
  AppEntity? actionBy;

  /// The entity for whom the action was performed.
  AppEntity? actionFor;

  /// The entity on whom the action was performed.
  AppEntity? actionOn;

  /// Constructs a new `Action` instance.
  Action({
    this.message,
    this.rawData,
    this.action,
    this.oldScope,
    this.newScope,
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
    Map<String, dynamic>? metadata = const {},
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
    this.actionBy,
    this.actionOn,
    this.actionFor,
    int? unreadRepliesCount,
    List<User>? mentionedUsers,
    bool? hasMentionedMe,
  }) : super(
          id: id ?? 0,
          muid: muid ?? '',
          sender: sender,
          receiver: receiver,
          receiverUid: receiverUid,
          type: type,
          receiverType: receiverType,
          category: category ?? CometChatMessageCategory.action,
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
          hasMentionedMe: hasMentionedMe,
          mentionedUsers: mentionedUsers ?? [],
        );

  /// Creates a new instance of the Action class from a map.
  factory Action.fromMap(dynamic map) {
    if (map == null) {
      throw ArgumentError('The type of action map is null');
    }

    final appEntity = (map['receiverType'] == 'user')
        ? User.fromMap(map['receiver'])
        : Group.fromMap(map['receiver']);

    AppEntity? getAppEntity(dynamic map) {
      AppEntity? returningEntity;
      if (map == null) {
        return null;
      }
      if (map['uid'] != null) {
        returningEntity = User.fromMap(map);
      } else if (map['guid'] != null) {
        returningEntity = Group.fromMap(map);
      } else if (map['id'] != null) {
        return (BaseMessage.fromMap(map));
      }
      return returningEntity;
    }

    Action message = Action(
        message: map['message'] ?? '',
        rawData: map['rawData'] ?? '{}',
        action: map['action'].toString(),
        oldScope: map['oldScope'].toString(),
        newScope: map['newScope'].toString(),
        id: map['id'],
        muid: map['muid'],
        sender: User.fromMap(map['sender']),
        receiver: appEntity,
        receiverUid: map['receiverUid'],
        type: map['type'],
        receiverType: map['receiverType'],
        category: map['category'],
        sentAt: map['sentAt']>0? DateTime.fromMillisecondsSinceEpoch(map['sentAt'] * 1000):null,
        deliveredAt: map['deliveredAt']>0?
            DateTime.fromMillisecondsSinceEpoch(map['deliveredAt'] * 1000):null,
        readAt: map['readAt']>0? DateTime.fromMillisecondsSinceEpoch(map['readAt'] * 1000):null,
        metadata:
            Map<String, dynamic>.from(json.decode(map['metadata'] ?? '{}')),
        readByMeAt: map['readByMeAt']>0?
            DateTime.fromMillisecondsSinceEpoch(map['readByMeAt'] * 1000):null,
        deliveredToMeAt: map['deliveredToMeAt']>0?
            DateTime.fromMillisecondsSinceEpoch(map['deliveredToMeAt'] * 1000):null,
        deletedAt: map['deletedAt']>0? DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] * 1000):null,
        editedAt: map['editedAt']>0? DateTime.fromMillisecondsSinceEpoch(map['editedAt'] * 1000):null,
        deletedBy: map['deletedBy'],
        editedBy: map['editedBy'],
        updatedAt: map['updatedAt']>0? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] * 1000):null,
        conversationId: map['conversationId'],
        parentMessageId: map['parentMessageId'],
        replyCount: map['replyCount'],
        actionBy: getAppEntity(map['actionBy']),
        actionOn: getAppEntity(map['actionOn']),
        actionFor: getAppEntity(map['actionFor']),
        unreadRepliesCount: map['unreadRepliesCount'],
        mentionedUsers:
            map['mentionedUsers']?.map<User>((e) => User.fromMap(e)).toList() ??
                [],
        hasMentionedMe: map['hasMentionedMe'] ?? false);

    return message;
  }

  /// Generates a string representation of the `Action`.
  @override
  String toString() {
    return 'Action{message: $message, rawData: $rawData, action: $action, oldScope: $oldScope, newScope: $newScope}';
  }
}
