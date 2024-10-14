import '../../cometchat_sdk.dart';

class GroupPreferences {
  MessagesOptions? messages;
  RepliesOptions? replies;
  ReactionsOptions? reactions;
  MemberActionsOptions? memberLeft;
  MemberActionsOptions? memberAdded;
  MemberActionsOptions? memberJoined;
  MemberActionsOptions? memberKicked;
  MemberActionsOptions? memberBanned;
  MemberActionsOptions? memberUnbanned;
  MemberActionsOptions? memberScopeChanged;

  GroupPreferences(
      {this.messages,
      this.replies,
      this.memberLeft,
      this.memberAdded,
      this.memberJoined,
      this.memberKicked,
      this.memberBanned,
      this.memberUnbanned,
      this.memberScopeChanged,
      this.reactions});

  GroupPreferences.fromMap(dynamic map) {
    messages = MessagesOptions.fromValue(map['groupMessages']);
    replies = RepliesOptions.fromValue(map['groupReplies']);
    reactions = ReactionsOptions.fromValue(map['groupReactions']);
    memberLeft = MemberActionsOptions.fromValue(map['groupMemberLeft']);
    memberAdded = MemberActionsOptions.fromValue(map['groupMemberAdded']);
    memberJoined = MemberActionsOptions.fromValue(map['groupMemberJoined']);
    memberKicked = MemberActionsOptions.fromValue(map['groupMemberKicked']);
    memberBanned = MemberActionsOptions.fromValue(map['groupMemberBanned']);
    memberUnbanned = MemberActionsOptions.fromValue(map['groupMemberUnbanned']);
    memberScopeChanged =
        MemberActionsOptions.fromValue(map['groupMemberScopeChanged']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (messages != null) {
      data['groupMessages'] = messages?.value;
    }
    if (replies != null) {
      data['groupReplies'] = replies?.value;
    }
    if (reactions != null) {
      data['groupReactions'] = reactions?.value;
    }
    if (memberLeft != null) {
      data['groupMemberLeft'] = memberLeft?.value;
    }
    if (memberAdded != null) {
      data['groupMemberAdded'] = memberAdded?.value;
    }
    if (memberJoined != null) {
      data['groupMemberJoined'] = memberJoined?.value;
    }
    if (memberKicked != null) {
      data['groupMemberKicked'] = memberKicked?.value;
    }
    if (memberBanned != null) {
      data['groupMemberBanned'] = memberBanned?.value;
    }
    if (memberUnbanned != null) {
      data['groupMemberUnbanned'] = memberUnbanned?.value;
    }
    if (memberScopeChanged != null) {
      data['groupMemberScopeChanged'] = memberScopeChanged?.value;
    }
    return data;
  }
}
