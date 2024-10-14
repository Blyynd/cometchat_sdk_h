import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../cometchat_sdk.dart';

/// A request object for fetching conversations.
class ConversationsRequest {
  /// Maximum limit for the number of results.
  static const int maxLimit = 50;

  /// Default limit for the number of results.
  static const int defaultLimit = 30;

  /// Number of results to limit the query.
  final int? limit;

  /// Type of the conversation.
  final String? conversationType;

  /// Initial request flag.
  bool? init;

  /// Flag to include user and group tags.
  final bool? withUserAndGroupTags;

  /// Flag to include tags.
  final bool? withTags;

  /// Tags for filtering.
  final List<String>? tags;

  /// Flag to include blocked users.
  final bool? includeBlockedUsers;

  /// Flag to include blocked information.
  final bool? withBlockedInfo;

  /// Key for pagination.
  String? key;

  /// Builds the `ConversationsRequest` from the builder.
  ///
  /// This is a private constructor, only accessible by the builder.
  ConversationsRequest._builder(ConversationsRequestBuilder builder)
      : limit = builder.limit,
        conversationType = builder.conversationType,
        withUserAndGroupTags = builder.withUserAndGroupTags,
        withTags = builder.withTags ?? false,
        tags = builder.tags,
        init = true,
        includeBlockedUsers = builder.includeBlockedUsers ?? false,
        withBlockedInfo = builder.withBlockedInfo ?? false;

  ///Returns a list of [Conversation] object fetched after putting the filters.
  Future<List<Conversation>> fetchNext(
      {required Function(List<Conversation> message)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    try {
      final result = await channel.invokeMethod('fetchNextConversations', {
        'limit': this.limit,
        'type': this.conversationType,
        'init': this.init,
        'withUserAndGroupTags': withUserAndGroupTags,
        'withTags': this.withTags,
        'tags': this.tags,
        'key': this.key,
        'includeBlockedUsers': this.includeBlockedUsers,
        'withBlockedInfo': this.withBlockedInfo
      });
      final List<Conversation> res = [];
      if (result != null) {
        key = result["key"];
        debugPrint("key is $key");
        if (result["list"] != null) {
          for (var _obj in result["list"]) {
            try {
              res.add(Conversation.fromMap(_obj));
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
      if (onSuccess != null) {
        onSuccess(res);
      }
      this.init = false;
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
}

/// Builder class for `ConversationsRequest`.
///
/// Allows step-by-step creation of an `ConversationsRequest` object.
class ConversationsRequestBuilder {
  /// Number of results to limit the query.
  int? limit;

  /// Type of the conversation.
  String? conversationType;

  /// Flag to include user and group tags.
  bool? withUserAndGroupTags;

  /// Flag to include tags.
  bool? withTags;

  /// Tags for filtering.
  List<String>? tags;

  /// Flag to include blocked users.
  bool? includeBlockedUsers;

  /// Flag to include blocked information.
  bool? withBlockedInfo;

  /// Default constructor for `ConversationsRequestBuilder`.
  ConversationsRequestBuilder();

  /// Builds and returns an `ConversationsRequest` object.
  ConversationsRequest build() {
    return ConversationsRequest._builder(this);
  }
}
