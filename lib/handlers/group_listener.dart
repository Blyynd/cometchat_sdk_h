import '../cometchat_sdk.dart';

mixin GroupListener implements EventHandler {
  void onGroupMemberJoined(Action action, User joinedUser, Group joinedGroup) {}

  void onGroupMemberLeft(Action action, User leftUser, Group leftGroup) {}

  void onGroupMemberKicked(
      Action action, User kickedUser, User kickedBy, Group kickedFrom) {}

  void onGroupMemberBanned(
      Action action, User bannedUser, User bannedBy, Group bannedFrom) {}

  void onGroupMemberUnbanned(
      Action action, User unbannedUser, User unbannedBy, Group unbannedFrom) {}

  void onGroupMemberScopeChanged(
      Action action,
      User updatedBy,
      User updatedUser,
      String scopeChangedTo,
      String scopeChangedFrom,
      Group group) {}

  void onMemberAddedToGroup(
      Action action, User addedby, User userAdded, Group addedTo) {}
}
