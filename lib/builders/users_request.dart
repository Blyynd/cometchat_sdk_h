import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../cometchat_sdk.dart';

/// A request object for fetching users.
class UsersRequest {
  /// Number of results to limit the query.
  final int? limit;

  /// Token for pagination.
  final int? token;

  /// Keyword for searching.
  final String? searchKeyword;

  /// Flag to hide blocked users.
  final bool? hideBlockedUsers;

  /// Role of the users.
  final String? role;

  /// Flag to include only friends.
  final bool? friendsOnly;

  /// Roles for filtering.
  final List<String>? roles;

  /// Tags for filtering.
  final List<String>? tags;

  /// Flag to include tags.
  final bool? withTags;

  /// Status of the users.
  final String? userStatus;

  /// Page number for pagination.
  final int? nextPage;

  /// Total number of pages.
  final int? totalPages;

  /// Current page number.
  final int? currentPage;

  /// Flag to indicate fetching progress.
  final bool? inProgress;

  /// User ids for filtering.
  final List<String>? uids;

  /// Key for pagination.
  String? key;

  /// Builds the `UsersRequest` from the builder.
  ///
  /// This is a private constructor, only accessible by the builder.
  UsersRequest._builder(UsersRequestBuilder builder)
      : limit = builder.limit,
        token = builder.token,
        searchKeyword = builder.searchKeyword,
        hideBlockedUsers = builder.hideBlockedUsers,
        role = builder.role,
        friendsOnly = builder.friendsOnly,
        roles = builder.roles,
        tags = builder.tags,
        withTags = builder.withTags,
        userStatus = builder.userStatus,
        nextPage = builder.nextPage,
        totalPages = builder.totalPages,
        currentPage = builder.currentPage,
        inProgress = builder.inProgress,
        uids = builder.uids;

  /// Fetch a list of users based on the provided filters.
  ///
  /// This method could throw [PlatformException] with error codes specifying the cause.
  Future<List<User>> fetchNext(
      {required Function(List<User> userList)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    try {
      final result = await channel.invokeMethod('fetchUsers', {
        'searchTerm': this.searchKeyword,
        'limit': this.limit,
        'hidebloackedUsers': this.hideBlockedUsers,
        'userRoles': this.roles,
        'friendsOnly': this.friendsOnly,
        'tags': this.tags,
        'withTags': this.withTags,
        'userStatus': this.userStatus,
        'uids': this.uids,
        'key': this.key
      });
      final List<User> res = [];
      if (result != null) {
        key = result["key"];
        if (result["list"] != null) {
          for (var _obj in result["list"]) {
            try {
              res.add(User.fromMap(_obj));
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
      debugPrint("key is $key");
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

/// Builder class for `UsersRequest`.
///
/// Allows step-by-step creation of an `UsersRequest` object.
class UsersRequestBuilder {
  /// Number of results to limit the query.
  int? limit;

  /// Token for pagination.
  int? token;

  /// Keyword for searching.
  String? searchKeyword;

  /// Flag to hide blocked users.
  bool? hideBlockedUsers;

  /// Role of the users.
  String? role;

  /// Flag to include only friends.
  bool? friendsOnly;

  /// Roles for filtering.
  List<String>? roles;

  /// Tags for filtering.
  List<String>? tags;

  /// Flag to include tags.
  bool? withTags;

  /// Status of the users.
  String? userStatus;

  /// Page number for pagination.
  int? nextPage;

  /// Total number of pages.
  int? totalPages;

  /// Current page number.
  int? currentPage;

  /// Flag to indicate fetching progress.
  bool? inProgress;

  /// User ids for filtering.
  List<String>? uids;

  /// Default constructor for `UsersRequestBuilder`.
  UsersRequestBuilder();

  /// Builds and returns an `UsersRequest` object.
  UsersRequest build() {
    return UsersRequest._builder(this);
  }
}
