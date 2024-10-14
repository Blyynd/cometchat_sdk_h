import '../cometchat_sdk.dart';

mixin MessageListener implements EventHandler {
  void onTextMessageReceived(TextMessage textMessage) {}

  void onMediaMessageReceived(MediaMessage mediaMessage) {}

  void onCustomMessageReceived(CustomMessage customMessage) {}

  void onTypingStarted(TypingIndicator typingIndicator) {}

  void onTypingEnded(TypingIndicator typingIndicator) {}

  void onMessagesDelivered(MessageReceipt messageReceipt) {}

  void onMessagesRead(MessageReceipt messageReceipt) {}

  void onMessagesDeliveredToAll(MessageReceipt messageReceipt) {}

  void onMessagesReadByAll(MessageReceipt messageReceipt) {}

  void onMessageEdited(BaseMessage message) {}

  void onMessageDeleted(BaseMessage message) {}

  void onTransientMessageReceived(TransientMessage message) {}

  void onInteractiveMessageReceived(InteractiveMessage message) {}

  void onInteractionGoalCompleted(InteractionReceipt receipt) {}

  void onMessageReactionAdded(ReactionEvent reactionEvent) {}

  void onMessageReactionRemoved(ReactionEvent reactionEvent) {}
}
