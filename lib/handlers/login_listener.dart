import '../cometchat_sdk.dart';

mixin LoginListener implements EventHandler {
  void loginSuccess(User user) {}

  void loginFailure(CometChatException e) {}

  void logoutSuccess() {}

  void logoutFailure(CometChatException e) {}
}
