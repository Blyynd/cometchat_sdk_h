import 'package:flutter/services.dart';
import '../cometchat_sdk.dart';

/// A request object for fetching banned group members.
class BannedGroupMembersRequest {
  /// The direction indicating that the current user has blocked the other user.
  static final String directionBlockedByMe = "blockedByMe";

  /// The direction indicating that the other user has blocked the current user.
  static final String directionHasBlockedMe = "hasBlockedMe";

  /// The direction indicating that both users have blocked each other.
  static final String directionBoth = "both";

  /// Maximum limit for the number of results.
  static final int maxLimit = 100;

  /// Default limit for the number of results.
  static final int defaultLimit = 30;

  /// Group ID for the group whose banned members are to be fetched.
  final String guid;

  /// Number of results to limit the query.
  final int limit;

  /// Keyword for searching.
  final String? searchKeyword;

  /// Scopes for filtering.
  final List<String>? scopes;

  /// Key for pagination.
  String? key;

  /// Builds the `BannedGroupMembersRequest` from the builder.
  ///
  /// This is a private constructor, only accessible by the builder.
  BannedGroupMembersRequest._builder(BannedGroupMembersRequestBuilder builder)
      : limit = builder.limit ?? defaultLimit,
        guid = builder.guid,
        searchKeyword = builder.searchKeyword,
        scopes = builder.scopes;

  ///fetch the list of Users that logged-in user have blocked.
  Future<List<GroupMember>> fetchNext(
      {required Function(List<GroupMember> groupList)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    try {
      final result = await channel.invokeMethod('fetchBlockedGroupMembers', {
        'limit': this.limit,
        'searchKeyword': this.searchKeyword,
        'guid': this.guid,
        'scopes': this.scopes,
        'key': this.key
      });
      final List<GroupMember> res = [];
      if (result != null) {
        key = result["key"];
        if (result["list"] != null) {
          for (var _obj in result["list"]) {
            try {
              res.add(GroupMember.fromMap(_obj));
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
      return res;
    } on PlatformException catch (platformException) {
      if (onError != null) {
        onError(CometChatException(platformException.code,
            platformException.details, platformException.message));
      }
    } catch (e) {
      if (onError != null) {
        onError(CometChatException(
            ErrorCode.errorUnhandledException, e.toString(), e.toString()));
      }
    }
    return [];
  }
}

/// Builder class for `BannedGroupMembersRequest`.
///
/// Allows step-by-step creation of an `BannedGroupMembersRequest` object.
class BannedGroupMembersRequestBuilder {
  /// Group ID for the group whose banned members are to be fetched.
  String guid;

  /// Number of results to limit the query.
  int? limit;

  /// Keyword for searching.
  String? searchKeyword;

  /// Scopes for filtering.
  List<String>? scopes;

  /// Constructor for `BannedGroupMembersRequestBuilder` that requires group id.
  BannedGroupMembersRequestBuilder({required this.guid});

  /// Builds and returns an `BannedGroupMembersRequest` object.
  BannedGroupMembersRequest build() {
    return BannedGroupMembersRequest._builder(this);
  }
}
