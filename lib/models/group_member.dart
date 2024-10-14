import 'dart:convert';
import '../cometchat_sdk.dart';

/// Represents a group member within the chat.
///
/// This class extends [User] and adds additional properties
/// specifically related to a group member, such as the scope and joinedAt
class GroupMember extends User {
  String? scope;
  DateTime? joinedAt;

  /// Constructs a new `GroupMember` instance.
  GroupMember({
    required this.scope,
    this.joinedAt,
    required String uid,
    required String name,
    String? avatar,
    String? link,
    required String role,
    required String status,
    String? statusMessage,
    DateTime? lastActiveAt,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    bool? hasBlockedMe,
    bool? blockedByMe,
  }) : super(
            uid: uid,
            name: name,
            avatar: avatar,
            link: link,
            role: role,
            status: status,
            statusMessage: statusMessage,
            lastActiveAt: lastActiveAt,
            tags: tags,
            metadata: metadata,
            hasBlockedMe: hasBlockedMe,
            blockedByMe: blockedByMe);

  /// Constructs a new `GroupMember` instance from a UID.
  GroupMember.fromUid(
      {required this.scope, required String uid, required String name})
      : super.fromUID(uid: uid, name: name);

  /// Creates a new `GroupMember` instance from a map.
  factory GroupMember.fromMap(dynamic map) {
    if (map == null) {
      throw ArgumentError('The type of group member map is null');
    }
    return GroupMember(
      scope: map['scope']?.toString() ?? '',
      joinedAt: DateTime.fromMillisecondsSinceEpoch(map['joinedAt'] * 1000),
      uid: map['uid'],
      name: map['name'],
      avatar: map['avatar'],
      link: map['link'],
      role: map['role'],
      status: map['status'],
      statusMessage: map['statusMessage'],
      lastActiveAt: map['lastActiveAt'] == 0 || map['lastActiveAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['lastActiveAt'] * 1000),
      tags: List<String>.from(map['tags'] ?? []),
      hasBlockedMe: map['hasBlockedMe'],
      blockedByMe: map['blockedByMe'],
      metadata: Map<String, dynamic>.from(json.decode(map['metadata'] ?? '{}')),
    );
  }

  /// Generates a map representing the `GroupMember`.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scope'] = this.scope;
    map['uid'] = this.uid;
    return map;
  }
}
