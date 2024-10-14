import '../cometchat_sdk.dart';

mixin UserListener implements EventHandler {
  void onUserOnline(User user) {}

  void onUserOffline(User user) {}
}
