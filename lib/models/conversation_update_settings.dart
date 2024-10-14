class ConversationUpdateSettings {
  bool callActivities = true;
  bool groupActions = true;
  bool customMessages = true;
  bool messageReplies = true;

  ConversationUpdateSettings(
      {required this.callActivities,
      required this.groupActions,
      required this.customMessages,
      required this.messageReplies});

  ConversationUpdateSettings.fromMap(map) {
    callActivities = map['callActivities'];
    groupActions = map['groupActions'];
    customMessages = map['customMessages'];
    messageReplies = map['messageReplies'];
  }

  Map<String, dynamic> toMap() {
    return {
      'callActivities': callActivities,
      'groupActions': groupActions,
      'customMessages': customMessages,
      'messageReplies': messageReplies,
    };
  }
}
