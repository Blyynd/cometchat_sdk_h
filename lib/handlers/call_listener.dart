import '../cometchat_sdk.dart';

mixin CallListener implements EventHandler {
  void onIncomingCallReceived(Call call) {}

  void onOutgoingCallAccepted(Call call) {}

  void onOutgoingCallRejected(Call call) {}

  void onIncomingCallCancelled(Call call) {}

  void onCallEndedMessageReceived(Call call) {}
}

mixin CallListener2 implements EventHandler {
  bool onIncomingCallReceived(Call call);
}
