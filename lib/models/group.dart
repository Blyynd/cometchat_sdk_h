import 'dart:convert';
import '../cometchat_sdk.dart';

/// Represents a group within the chat.
///
/// This class extends [AppEntity] and adds additional properties
/// specifically related to a group, such as the guid, owner, name, icon,
/// description, metadata, joined status, members count, creation time,
/// join time, update time, tags, type, scope, and password. It also includes
/// a boolean flag to determine if the user is banned from the group.
class Group extends AppEntity {
  String guid;
  String owner;
  String name;
  String? icon;
  String? description;
  Map<String, dynamic>? metadata;
  bool hasJoined;
  int membersCount;
  DateTime? createdAt;
  DateTime? joinedAt;
  DateTime? updatedAt;
  List<String> tags;
  String type;
  String? scope;
  String? password;
  bool? isBannedFromGroup = false;

  /// Constructs a new `Group` instance.
  ///
  /// Requires `guid`, `name`, and `type` to be specified. Other properties are optional.
  Group(
      {required this.guid,
      this.owner = '',
      required this.name,
      this.icon,
      this.description,
      this.hasJoined = false,
      this.membersCount = 0,
      this.createdAt,
      this.joinedAt,
      this.updatedAt,
      this.metadata,
      this.tags = const [],
      required this.type,
      this.scope,
      this.password,
      this.isBannedFromGroup});

  /// Creates a new `Group` instance from a map.
  factory Group.fromMap(dynamic map) {
    if (map == null) {
      throw ArgumentError('The type of group map is null');
    }
    return Group(
        guid: map['guid'],
        owner: map['owner'],
        name: map['name'],
        icon: map['icon'] ?? '',
        description: map['description'] ?? '',
        metadata:
            Map<String, dynamic>.from(json.decode(map['metadata'] ?? '{}')),
        hasJoined: map['hasJoined'],
        membersCount: map['membersCount'],
        createdAt: map['createdAt'] == 0 || map['createdAt'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['createdAt'] * 1000),
        joinedAt: map['joinedAt'] == 0 || map['joinedAt'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['joinedAt'] * 1000),
        updatedAt: map['updatedAt'] == 0 || map['updatedAt'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] * 1000),
        tags: List<String>.from(map['tags'] ?? []),
        type: map['type'],
        scope: map['scope'],
        password: map['password'],
        isBannedFromGroup: map['isBannedFromGroup']);
  }

  /// Generates a map representing the `Group`.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['guid'] = guid;
    map['name'] = name;
    map['icon'] = icon;
    map['description'] = description;
    map['membersCount'] = membersCount;
    map['metadata'] = metadata;
    map['joinedAt'] = joinedAt == null ? 0 : joinedAt?.millisecondsSinceEpoch;
    map['hasJoined'] = hasJoined;
    map['createdAt'] =
        createdAt == null ? 0 : createdAt?.millisecondsSinceEpoch;
    map['owner'] = owner;
    map['updatedAt'] =
        updatedAt == null ? 0 : updatedAt?.millisecondsSinceEpoch;
    map['tags'] = tags;
    map['type'] = type;
    map['scope'] = scope;
    map['password'] = password;
    map['isBannedFromGroup'] = isBannedFromGroup;
    return map;
  }

  /// Generates a map of the `Group`.
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['guid'] = guid;
    map['name'] = name;
    map['icon'] = icon;
    map['description'] = description;
    map['membersCount'] = membersCount;
    map['metadata'] = metadata;
    map['joinedAt'] = joinedAt;
    map['hasJoined'] = hasJoined;
    map['createdAt'] = createdAt;
    map['owner'] = owner;
    map['updatedAt'] = updatedAt;
    map['tags'] = tags;
    map['type'] = type;
    map['scope'] = scope;
    map['password'] = password;
    map['isBannedFromGroup'] = isBannedFromGroup;
    return map;
  }

  /// Generates a string representation of the `Group`.
  @override
  String toString() {
    return 'Group{guid: $guid, owner: $owner, name: $name, icon: $icon, description: $description, metadata: $metadata, hasJoined: $hasJoined, membersCount: $membersCount, createdAt: $createdAt, joinedAt: $joinedAt, updatedAt: $updatedAt, tags: $tags, type: $type, scope: $scope, password: $password, isBannedFromGroup: $isBannedFromGroup}';
  }
}
