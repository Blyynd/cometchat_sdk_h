import '../cometchat_sdk.dart';

mixin ConnectionListener implements EventHandler {
  void onConnected() {}

  void onConnecting() {}

  void onDisconnected() {}

  void onFeatureThrottled() {}

  void onConnectionError(CometChatException error) {}
}
