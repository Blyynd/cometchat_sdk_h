import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../cometchat_sdk.dart';

/// A request object for fetching group members.
class GroupMembersRequest {
  /// Maximum limit for the number of results.
  static final int maxLimit = 100;

  /// Default limit for the number of results.
  static const int defaultLimit = 30;

  /// Group ID for the group whose members are to be fetched.
  final String guid;

  /// Number of results to limit the query.
  final int limit;

  /// Keyword for searching.
  final String? searchKeyword;

  /// Scopes for filtering.
  final List<String>? scopes;

  /// Key for pagination.
  String? key;

  /// Builds the `GroupMembersRequest` from the builder.
  ///
  /// This is a private constructor, only accessible by the builder.
  GroupMembersRequest._builder(GroupMembersRequestBuilder builder)
      : limit = builder.limit ?? maxLimit,
        guid = builder.guid,
        searchKeyword = builder.searchKeyword,
        scopes = builder.scopes;

  ///fetch the list of groups members for a group , returns List of [GroupMember].
  Future<List<GroupMember>> fetchNext(
      {required Function(List<GroupMember> groupMemberList)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    try {
      final result = await channel.invokeMethod('fetchNextGroupMembers', {
        'guid': this.guid,
        'limit': this.limit,
        'keyword': this.searchKeyword,
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
}

/// Builder class for `GroupMembersRequest`.
///
/// Allows step-by-step creation of an `GroupMembersRequest` object.
class GroupMembersRequestBuilder {
  /// Group ID for the group whose members are to be fetched.
  String guid;

  /// Number of results to limit the query.
  int? limit;

  /// Keyword for searching.
  String? searchKeyword;

  /// Scopes for filtering.
  List<String>? scopes;

  /// Constructor for `GroupMembersRequestBuilder` that requires group id.
  GroupMembersRequestBuilder(this.guid);

  /// Builds and returns an `GroupMembersRequest` object.
  GroupMembersRequest build() {
    return GroupMembersRequest._builder(this);
  }
}
