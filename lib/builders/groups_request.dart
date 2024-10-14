import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../cometchat_sdk.dart';

/// A request object for fetching groups.
class GroupsRequest {
  /// Maximum limit for the number of results.
  static final int maxLimit = 100;

  /// Default limit for the number of results.
  static const int defaultLimit = 30;

  /// Number of results to limit the query.
  final int? limit;

  /// Keyword for searching.
  final String? searchKeyword;

  /// Flag to include only joined groups.
  final bool? joinedOnly;

  /// Tags for filtering.
  final List<String>? tags;

  /// Flag to include tags.
  final bool? withTags;

  /// Key for pagination.
  String? key;

  /// Builds the `GroupsRequest` from the builder.
  ///
  /// This is a private constructor, only accessible by the builder.
  GroupsRequest._builder(GroupsRequestBuilder builder)
      : limit = builder.limit ?? maxLimit,
        searchKeyword = builder.searchKeyword,
        joinedOnly = builder.joinedOnly,
        tags = builder.tags,
        withTags = builder.withTags;

  ///Returns list of  [Group] object fetched after putting the filters.
  Future<List<Group>> fetchNext(
      {required Function(List<Group> groupList)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    try {
      final result = await channel.invokeMethod('fetchNextGroups', {
        'searchTerm': this.searchKeyword,
        'limit': this.limit,
        'joinedOnly': this.joinedOnly,
        'tags': this.tags,
        'withTags': this.withTags,
        'key': this.key
      });
      final List<Group> res = [];
      if (result != null) {
        key = result["key"];
        if (result["list"] != null) {
          for (var _obj in result["list"]) {
            try {
              res.add(Group.fromMap(_obj));
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

/// Builder class for `GroupsRequest`.
///
/// Allows step-by-step creation of an `GroupsRequest` object.
class GroupsRequestBuilder {
  /// Number of results to limit the query.
  int? limit;

  /// Keyword for searching.
  String? searchKeyword;

  /// Flag to include only joined groups.
  bool? joinedOnly = false;

  /// Tags for filtering.
  List<String>? tags;

  /// Flag to include tags.
  bool? withTags = false;

  /// Default constructor for `GroupsRequestBuilder`.
  GroupsRequestBuilder();

  /// Builds and returns an `GroupsRequest` object.
  GroupsRequest build() {
    return GroupsRequest._builder(this);
  }
}
