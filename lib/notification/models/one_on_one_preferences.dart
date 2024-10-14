import '../../cometchat_sdk.dart';

class OneOnOnePreferences {
  RepliesOptions? replies;
  MessagesOptions? messages;
  ReactionsOptions? reactions;

  OneOnOnePreferences({this.replies, this.messages, this.reactions});

  OneOnOnePreferences.fromMap(dynamic map) {
    replies = RepliesOptions.fromValue(map['oneOnOneReplies']);
    messages = MessagesOptions.fromValue(map['oneOnOneMessages']);
    reactions = ReactionsOptions.fromValue(map['oneOnOneReactions']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (replies != null) {
      data['oneOnOneReplies'] = replies?.value;
    }
    if (messages != null) {
      data['oneOnOneMessages'] = messages?.value;
    }
    if (reactions != null) {
      data['oneOnOneReactions'] = reactions?.value;
    }
    return data;
  }
}
