class CometChatNotificationErrorCode {
  static const String ERROR_INVALID_PUSH_PLATFORM = 'INVALID_PUSH_PLATFORM';
  static const String ERROR_INVALID_FCM_TOKEN = 'INVALID_FCM_TOKEN';
  static const String ERROR_INVALID_APNS_DEVICE_TOKEN =
      'INVALID_APNS_DEVICE_TOKEN';
  static const String ERROR_INVALID_APNS_VOIP_TOKEN = 'INVALID_APNS_VOIP_TOKEN';
}

class CometChatNotificationErrorMessages {
  static const String ERROR_MESSAGE_INVALID_PUSH_PLATFORM =
      'An invalid Push Platform was detected. Please submit a valid push platform to proceed.';
  static const String ERROR_MESSAGE_INVALID_FCM_TOKEN =
      'An invalid FCM token was detected. Please submit a valid token to proceed.';
  static const String ERROR_MESSAGE_APNS_INVALID_DEVICE_TOKEN =
      'An invalid APNs Device token was detected. Please submit a valid token to proceed.';
  static const String ERROR_MESSAGE_APNS_INVALID_VOIP_TOKEN =
      'An invalid APNs VoIP token was detected. Please submit a valid token to proceed.';
}
