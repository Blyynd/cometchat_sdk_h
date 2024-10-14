import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../cometchat_sdk.dart';

/// A request object for fetching messages.
class MessagesRequest {
  /// Maximum limit for the number of results.
  static final int? maxLimit = 100;

  /// Default limit for the number of results.
  static final int? defaultLimit = 30;

  /// User ID for which the messages are to be fetched.
  final String? uid;

  /// Group ID for which the messages are to be fetched.
  final String? guid;

  /// Number of results to limit the query.
  final int? limit;

  /// Message ID from which the messages are to be fetched.
  final int? messageId;

  /// Timestamp from which the messages are to be fetched.
  final DateTime? timestamp;

  /// Flag to include only unread messages.
  final bool? unread;

  /// Flag to hide messages from blocked users.
  final bool? hideMessagesFromBlockedUsers;

  /// Keyword for searching.
  final String? searchKeyword;

  /// Time from which the messages are to be updated.
  final DateTime? updatedAfter;

  /// Flag to include only updates.
  final bool? updatesOnly;

  /// Category of the messages.
  final String? category;

  /// Type of the messages.
  final String? type;

  /// Parent message ID for thread messages.
  final int? parentMessageId;

  /// Flag to hide replies.
  final bool? hideReplies;

  /// Flag to hide deleted messages.
  final bool? hideDeleted;

  /// Categories for filtering.
  final List<String>? categories;

  /// Types for filtering.
  final List<String>? types;

  /// Flag to include tags.
  final bool? withTags;

  /// Tags for filtering.
  final List<String>? tags;

  /// Flag to include messages with completed interaction goals.
  final bool? interactionGoalCompletedOnly;

  /// Key for pagination.
  String? key;

  /// [_myMentionsOnly] fetch messages where any user is mentioned.
  final bool? _myMentionsOnly;

  /// [_mentionsWithTagInfo] fetch messages where any user is mentioned. The user object will contain the tags of the mentioned user.
  final bool? _mentionsWithTagInfo;

  /// [_mentionsWithBlockedInfo] fetch messages where any user is mentioned. The user object will contain the blockedByMe and blockedAt etc. properties of the mentioned user.
  final bool? _mentionsWithBlockedInfo;

  MessagesRequest._builder(MessagesRequestBuilder builder)
      : limit = builder.limit ?? maxLimit,
        uid = builder.uid,
        guid = builder.guid,
        messageId = builder.messageId,
        timestamp = builder.timestamp,
        unread = builder.unread,
        hideMessagesFromBlockedUsers = builder.hideMessagesFromBlockedUsers,
        searchKeyword = builder.searchKeyword,
        updatedAfter = builder.updatedAfter,
        updatesOnly = builder.updatesOnly,
        category = builder.category,
        type = builder.type,
        parentMessageId = builder.parentMessageId,
        hideReplies = builder.hideReplies,
        hideDeleted = builder.hideDeleted,
        categories = builder.categories,
        types = builder.types,
        withTags = builder.withTags ?? false,
        tags = builder.tags,
        _myMentionsOnly = builder._myMentionsOnly ?? false,
        _mentionsWithTagInfo = builder._mentionsWithTagInfo ?? false,
        _mentionsWithBlockedInfo = builder._mentionsWithBlockedInfo ?? false,
        interactionGoalCompletedOnly =
            builder.interactionGoalCompletedOnly ?? false;

  ///Returns a list of [BaseMessage] object fetched after putting the filters.
  Future<List<BaseMessage>> fetchNext(
      {required Function(List<BaseMessage> message)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    try {
      int? updateAfterLong;
      int? timestampLong;
      if (this.updatedAfter != null) {
        updateAfterLong = this.updatedAfter!.millisecondsSinceEpoch ~/ 1000;
      }
      if (this.timestamp != null) {
        timestampLong = this.timestamp!.millisecondsSinceEpoch ~/ 1000;
      }
      final result = await channel.invokeMethod('fetchNextMessages', {
        'uid': this.uid,
        'guid': this.guid,
        'searchTerm': this.searchKeyword,
        'messageId': this.messageId,
        'limit': this.limit,
        'timestamp': timestampLong,
        'unread': this.unread,
        'hideblockedUsers': this.hideMessagesFromBlockedUsers,
        'updateAfter': updateAfterLong,
        'updatesOnly': this.updatesOnly,
        'categories': this.categories,
        'types': this.types,
        'parentMessageId': this.parentMessageId,
        'hideReplies': this.hideReplies,
        'hideDeletedMessages': this.hideDeleted,
        'withTags': this.withTags,
        'tags': this.tags,
        'key': this.key,
        'myMentionsOnly': this._myMentionsOnly ?? false,
        'mentionsWithTagInfo': this._mentionsWithTagInfo ?? false,
        'mentionsWithBlockedInfo': this._mentionsWithBlockedInfo ?? false,
        'interactionGoalCompletedOnly': this.interactionGoalCompletedOnly
      });
      final List<BaseMessage> res = [];
      if (result != null) {
        key = result["key"];
        if (result["list"] != null) {
          for (var _obj in result["list"]) {
            try {
              res.add(BaseMessage.fromMap(_obj));
            } catch (e) {
              if (onError != null) {
                onError(CometChatException(ErrorCode.errorUnhandledException,
                    e.toString(), e.toString()));
              }
              return [];
            }
          }
        }
      }
      if (onSuccess != null) onSuccess(res);
      return res;
    } on PlatformException catch (platformException) {
      if (onError != null) {
        onError(CometChatException(platformException.code,
            platformException.details, platformException.message));
      }
    } catch (e) {
      debugPrint("Error: $e");
      if (onError != null) {
        onError(CometChatException(
            ErrorCode.errorUnhandledException, e.toString(), e.toString()));
      }
    }
    return [];
  }

  ///Returns a list of [BaseMessage] object fetched after putting the filters.
  Future<List<BaseMessage>> fetchPrevious(
      {required Function(List<BaseMessage> message)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    try {
      int? updateAfterLong;
      int? timestampLong;
      if (this.updatedAfter != null) {
        updateAfterLong = this.updatedAfter!.millisecondsSinceEpoch ~/ 1000;
      }
      if (this.timestamp != null) {
        timestampLong = this.timestamp!.millisecondsSinceEpoch ~/ 1000;
      }
      final result = await channel.invokeMethod('fetchPreviousMessages', {
        'uid': this.uid,
        'guid': this.guid,
        'searchTerm': this.searchKeyword,
        'messageId': this.messageId,
        'limit': this.limit,
        'timestamp': timestampLong,
        'unread': this.unread,
        'hideblockedUsers': this.hideMessagesFromBlockedUsers,
        'updateAfter': updateAfterLong,
        'updatesOnly': this.updatesOnly,
        'categories': this.categories,
        'types': this.types,
        'parentMessageId': this.parentMessageId,
        'hideReplies': this.hideReplies,
        'hideDeletedMessages': this.hideDeleted,
        'withTags': this.withTags,
        'tags': this.tags,
        'key': this.key,
        'myMentionsOnly': this._myMentionsOnly ?? false,
        'mentionsWithTagInfo': this._mentionsWithTagInfo ?? false,
        'mentionsWithBlockedInfo': this._mentionsWithBlockedInfo ?? false,
        'interactionGoalCompletedOnly': this.interactionGoalCompletedOnly
      });
      final List<BaseMessage> res = [];
      if (result != null) {
        key = result["key"];
        debugPrint("key in SDK $key");
        if (result["list"] != null) {
          for (var _obj in result["list"]) {
            try {
              res.add(BaseMessage.fromMap(_obj));
            } catch (e) {
              if (onError != null) {
                onError(CometChatException(ErrorCode.errorUnhandledException,
                    e.toString(), e.toString()));
              }
              return [];
            }
          }
        }
      }
      if (onSuccess != null) onSuccess(res);
      return res;
    } on PlatformException catch (platformException) {
      if (onError != null) {
        onError(CometChatException(platformException.code,
            platformException.details, platformException.message));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      if (onError != null) {
        onError(CometChatException(
            ErrorCode.errorUnhandledException, e.toString(), e.toString()));
      }
    }
    return [];
  }
}

/// Builder class for `MessagesRequest`.
///
/// Allows step-by-step creation of an `MessagesRequest` object.
class MessagesRequestBuilder {
  /// User ID for which the messages are to be fetched.
  String? uid;

  /// Group ID for which the messages are to be fetched.
  String? guid;

  /// Number of results to limit the query.
  int? limit;

  /// Message ID from which the messages are to be fetched.
  int? messageId;

  /// Timestamp from which the messages are to be fetched.
  DateTime? timestamp;

  /// Flag to include only unread messages.
  bool? unread;

  /// Flag to hide messages from blocked users.
  bool? hideMessagesFromBlockedUsers;

  /// Keyword for searching.
  String? searchKeyword;

  /// Time from which the messages are to be updated.
  DateTime? updatedAfter;

  /// Flag to include only updates.
  bool? updatesOnly;

  /// Category of the messages.
  String? category;

  /// Type of the messages.
  String? type;

  /// Parent message ID for thread messages.
  int? parentMessageId;

  /// Flag to hide replies.
  bool? hideReplies;

  /// Flag to hide deleted messages.
  bool? hideDeleted;

  /// Categories for filtering.
  List<String>? categories;

  /// Types for filtering.
  List<String>? types;

  /// Flag to include tags.
  bool? withTags;

  /// Tags for filtering.
  List<String>? tags;

  /// Flag to fetch messages where user is mentioned.
  bool? _myMentionsOnly;

  /// Flag to fetch messages with tag information.
  bool? _mentionsWithTagInfo;

  /// Flag to fetch messages with block information.
  bool? _mentionsWithBlockedInfo;

  /// Flag to include messages with completed interaction goals.
  bool? interactionGoalCompletedOnly;

  /// Default constructor for `MessagesRequestBuilder`.
  MessagesRequestBuilder();

  /// Builds and returns an `MessagesRequest` object.
  MessagesRequest build() {
    return MessagesRequest._builder(this);
  }

  /// Method to get messages where user is mentioned.
  MessagesRequestBuilder myMentionsOnly(bool myMentionsOnly) {
    this._myMentionsOnly = myMentionsOnly;
    return this;
  }

  /// Method to get messages with tag information.
  MessagesRequestBuilder mentionsWithTagInfo(bool mentionsWithTagInfo) {
    this._mentionsWithTagInfo = mentionsWithTagInfo;
    return this;
  }

  /// Method to get messages with block information.
  MessagesRequestBuilder mentionsWithBlockedInfo(bool mentionsWithBlockedInfo) {
    this._mentionsWithBlockedInfo = mentionsWithBlockedInfo;
    return this;
  }
}
