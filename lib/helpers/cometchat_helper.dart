import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../cometchat_sdk.dart';

class CometChatHelper {
  /// Retrieves the [Conversation] object associated with the given [message].
  ///
  /// The [message] parameter represents the [BaseMessage] for which the corresponding [Conversation] is required.
  ///
  /// Returns a [Future] that resolves to the [Conversation] associated with the [message].
  /// Returns `null` if an error occurs during the retrieval process or if the logged-in user is null.
  static Future<Conversation?> getConversationFromMessage(
      BaseMessage message) async {
    try {
      String conversationType = message.receiverType;
      User? loggedInUser = await CometChat.getLoggedInUser();
      String? conversationId = message.conversationId;
      if (loggedInUser != null) {
        AppEntity appEntity = AppEntity();
        if (conversationType == CometChatReceiverType.user) {
          if (loggedInUser.uid == message.sender!.uid) {
            appEntity = message.receiver!;
          } else {
            appEntity = message.sender!;
          }
        } else {
          appEntity = message.receiver!;
        }
        Conversation conversation = Conversation(
            conversationId: conversationId,
            conversationType: conversationType,
            conversationWith: appEntity,
            lastMessage: message,
            updatedAt: message.updatedAt);
        return conversation;
      } else {
        return null;
      }
    } on PlatformException catch (platformException) {
      debugPrint("Error: $platformException");
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }

  /// Updates the [baseMessage] with the reaction information provided in [messageReaction].
  ///
  /// The [action] parameter specifies the type of reaction action, which can be either [ReactionAction.reactionAdded] or [ReactionAction.reactionRemoved].
  /// Returns a [Future] that resolves to the updated [baseMessage].
  /// Returns `null` if an error occurs during the process.
  static Future<BaseMessage?> updateMessageWithReactionInfo(
      BaseMessage baseMessage, Reaction messageReaction, String action) async {
    try {
      final loggedInUserObj = await CometChat.getLoggedInUser();
      if (action == ReactionAction.reactionAdded) {
        if (baseMessage.id == messageReaction.messageId) {
          if (baseMessage.reactions.isNotEmpty) {
            int foundReactionIndex = -1;
            for (int j = 0; j < baseMessage.reactions.length; j++) {
              ReactionCount reactionCount = baseMessage.reactions[j];
              if (reactionCount.reaction == messageReaction.reaction) {
                foundReactionIndex = j;
                break;
              }
            }
            if (foundReactionIndex != -1) {
              ReactionCount tempReactionCount =
                  baseMessage.reactions[foundReactionIndex];
              baseMessage.reactions[foundReactionIndex].count =
                  tempReactionCount.count! + 1;
              if (loggedInUserObj?.uid == messageReaction.uid) {
                baseMessage.reactions[foundReactionIndex].reactedByMe = true;
              }
            } else {
              ReactionCount tempReactionCount = ReactionCount();
              tempReactionCount.count = 1;
              tempReactionCount.reaction = messageReaction.reaction;
              if (loggedInUserObj?.uid == messageReaction.uid) {
                tempReactionCount.reactedByMe = true;
              }
              baseMessage.reactions.add(tempReactionCount);
            }
          } else {
            ReactionCount reactionCount = ReactionCount();
            reactionCount.count = 1;
            reactionCount.reaction = messageReaction.reaction;
            if (loggedInUserObj?.uid == messageReaction.uid) {
              reactionCount.reactedByMe = true;
            }
            baseMessage.reactions.add(reactionCount);
          }
          return baseMessage;
        }
      } else if (action == ReactionAction.reactionRemoved) {
        if (baseMessage.id == messageReaction.messageId) {
          if (baseMessage.reactions.isNotEmpty) {
            int foundReactionIndex = -1;
            for (int j = 0; j < baseMessage.reactions.length; j++) {
              ReactionCount reactionCount = baseMessage.reactions[j];
              if (reactionCount.reaction == messageReaction.reaction) {
                foundReactionIndex = j;
                break;
              }
            }
            if (foundReactionIndex != -1) {
              ReactionCount tempReactionCount =
                  baseMessage.reactions[foundReactionIndex];
              if (tempReactionCount.count! > 1) {
                baseMessage.reactions[foundReactionIndex].count =
                    tempReactionCount.count! - 1;
                if (loggedInUserObj?.uid == messageReaction.uid) {
                  baseMessage.reactions[foundReactionIndex].reactedByMe = false;
                }
              } else {
                baseMessage.reactions.removeAt(foundReactionIndex);
              }
            }
          }
          return baseMessage;
        }
      }
    } on PlatformException catch (platformException) {
      debugPrint("Error: $platformException");
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }
}
