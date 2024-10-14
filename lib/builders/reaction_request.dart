import 'package:flutter/services.dart';
import '../cometchat_sdk.dart';

/// A request object for fetching reactions.
class ReactionsRequest {
  /// Maximum limit for the number of results.
  final int? maxLimit = 20;

  /// Default limit for the number of results.
  final int? defaultLimit = 10;

  /// Key for pagination.
  String? key;

  /// Number of results to limit the query.
  int limit = 10;

  /// Message ID for which the reactions are to be fetched.
  int? messageId = 0;

  /// Specific reaction to be fetched.
  String? reaction;

  /// Builds the `ReactionsRequest` from the builder.
  ///
  /// This is a private constructor, only accessible by the builder.
  ReactionsRequest._builder(ReactionsRequestBuilder builder)
      : limit = builder.limit,
        messageId = builder.messageId,
        reaction = builder.reaction;

  /// Asynchronously fetches the next set of reactions for a particular message.
  ///
  /// This function will invoke the 'fetchNextMessageRequest' method on the platform-specific implementation,
  /// passing the limit, messageId, and reaction as parameters.
  /// The limit parameter defines the maximum number of message reactions to fetch.
  /// The messageId parameter specifies the ID of the message for which reactions are to be fetched.
  /// The reaction parameter specifies the reaction to filter with.
  ///
  /// Upon success, the function will convert the result into a list of MessageReaction objects and call the onSuccess callback with this list.
  /// If an exception occurs during the fetch operation or the conversion of the result, the onError callback will be called with a CometChatException.
  ///
  /// @param onSuccess A callback function which is called when the function successfully fetches the next set of reactions. This function is passed the list of fetched MessageReaction objects.
  /// @param onError A callback function which is called when an exception occurs during the fetch operation or the conversion of the result. This function is passed a CometChatException detailing the error.
  /// @return A Future that completes with a list of MessageReaction objects. If an error occurs, the future completes with an empty list.
  ///
  Future<List<Reaction>> fetchNext(
      {required Function(List<Reaction> message)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    return await _fetchNextAndPreviousForReactionsRequest(0,
        onSuccess: onSuccess, onError: onError);
  }

  /// Asynchronously fetches the previous set of reactions for a specific message.
  ///
  /// This method invokes the 'fetchNextMessageRequest' method on the platform-specific implementation,
  /// with 'limit', 'messageId', and 'reaction' passed as parameters.
  /// The 'limit' parameter defines the max number of message reactions to be fetched.
  /// The 'messageId' specifies the ID of the message for which the reactions are fetched.
  /// The 'reaction' parameter specifies the reaction to be used for filtering.
  ///
  /// If successful, this function will convert the result into a list of MessageReaction objects and will call the onSuccess callback with this list.
  /// If an exception is thrown during the fetch operation or during the conversion of the result, onError callback will be invoked with a CometChatException.
  ///
  /// @param onSuccess A callback function to be invoked upon the successful fetching of previous reactions. This function receives a list of fetched MessageReaction objects as a parameter.
  /// @param onError A callback function to be invoked when an exception is thrown during the fetch operation or the conversion of the result. This function will receive a CometChatException that details the error.
  /// @return A Future that completes with a list of MessageReaction objects. If an error is encountered, the future completes with an empty list.
  ///
  Future<List<Reaction>> fetchPrevious(
      {required Function(List<Reaction> message)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    return await _fetchNextAndPreviousForReactionsRequest(1,
        onSuccess: onSuccess, onError: onError);
  }

  _fetchNextAndPreviousForReactionsRequest(int paginationTask,
      {required Function(List<Reaction> message)? onSuccess,
      required Function(CometChatException excep)? onError}) async {
    final List<Reaction> res = [];
    try {
      final result = await channel
          .invokeMethod('fetchNextAndPreviousForReactionsRequest', {
        'paginationTask': paginationTask,
        'limit': this.limit,
        'messageId': this.messageId,
        'reaction': this.reaction,
        'key': this.key
      });
      if (result != null) {
        key = result["key"];
        if (result["list"] != null) {
          for (var _obj in result["list"]) {
            res.add(Reaction.fromMap(_obj));
          }
        }
      }
      if (onSuccess != null) onSuccess(res);
    } on PlatformException catch (platformException) {
      if (onError != null) {
        onError(CometChatException(platformException.code,
            platformException.message, platformException.message));
      }
    } catch (e) {
      if (onError != null) {
        onError(CometChatException(
            ErrorCode.errorUnhandledException, e.toString(), e.toString()));
      }
    }
    return res;
  }
}

/// Builder class for `ReactionsRequest`.
///
/// Allows step-by-step creation of an `ReactionsRequest` object.
class ReactionsRequestBuilder {
  /// Number of results to limit the query.
  int limit = 10;

  /// Message ID for which the reactions are to be fetched.
  int? messageId = -1;

  /// Specific reaction to be fetched.
  String? reaction;

  /// Default constructor for `ReactionsRequestBuilder`.
  ReactionsRequestBuilder();

  /// Builds and returns an `ReactionsRequest` object.
  ReactionsRequest build() {
    return ReactionsRequest._builder(this);
  }
}
