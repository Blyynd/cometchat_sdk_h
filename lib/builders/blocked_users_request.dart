import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../cometchat_sdk.dart';

/// A request object for fetching blocked users.
class BlockedUsersRequest {
  /// Constants for different blocking directions.
  static final String directionBlockedByMe = "blockedByMe";
  static final String directionHasBlockedMe = "hasBlockedMe";
  static final String directionBoth = "both";

  /// Maximum limit for the number of results.
  static final int maxLimit = 100;

  /// Default limit for the number of results.
  static final int defaultLimit = 30;

  /// Number of results to limit the query.
  final int? limit;

  /// The token for pagination.
  final int? token;

  /// Keyword for searching.
  final String? searchKeyword;

  /// Direction for fetching blocked users.
  final String? direction;

  /// Key for pagination.
  String? key;

  /// Builds the `BlockedUsersRequest` from the builder.
  ///
  /// This is a private constructor, only accessible by the builder.
  BlockedUsersRequest._builder(BlockedUsersRequestBuilder builder)
      : limit = builder.limit,
        token = builder.token,
        searchKeyword = builder.searchKeyword,
        direction = builder.direction;

  ///fetch the list of Users that logged-in user have blocked.
  Future<List<User>> fetchNext(
      {required Function(List<User> userList)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    try {
      final result = await channel.invokeMethod('fetchBlockedUsers', {
        'limit': this.limit,
        'searchKeyword': this.searchKeyword,
        'direction': this.direction,
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

/// Builder class for `BlockedUsersRequest`.
///
/// Allows step-by-step creation of an `BlockedUsersRequest` object.
class BlockedUsersRequestBuilder {
  /// Number of results to limit the query.
  int? limit;

  /// The token for pagination.
  int? token;

  /// Keyword for searching.
  String? searchKeyword;

  /// Direction for fetching blocked users.
  String? direction;

  /// Default constructor for `BlockedUsersRequestBuilder`.
  BlockedUsersRequestBuilder();

  /// Builds and returns an `BlockedUsersRequest` object.
  BlockedUsersRequest build() {
    return BlockedUsersRequest._builder(this);
  }
}
