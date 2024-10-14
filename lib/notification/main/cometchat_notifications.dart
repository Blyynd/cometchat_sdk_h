import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../cometchat_sdk.dart';

class CometChatNotifications {
  /// Retrieves the current push notification preferences for the logged-in user.
  ///
  /// This method makes an asynchronous call to fetch the [PushPreferences] from CometChat servers.
  /// Upon successful retrieval, [onSuccess] is invoked with the [PushPreferences] object.
  /// In the case of an error, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<PushPreferences?>] which completes with the fetched preferences,
  /// or null if an error occurs.
  @Deprecated('This method has been deprecated. Please use [fetchPreferences] instead.')
  static Future<PushPreferences?> fetchPushPreferences(
      {Function(PushPreferences pushPreferences)? onSuccess,
      Function(CometChatException e)? onError}) async {
    try {
      final result = await channel.invokeMethod('fetchPreferences');
      final pushPreferencesObj = PushPreferences.fromMap(result);
      if (onSuccess != null) onSuccess(pushPreferencesObj);
      return pushPreferencesObj;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Updates the push notification preferences for the logged-in user.
  ///
  /// This method asynchronously sends the updated [PushPreferences] to the CometChat server.
  /// If the update is successful, [onSuccess] is called with the updated [PushPreferences] object.
  /// If an error occurs during the update, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<PushPreferences?>] that resolves to the updated preferences, or null if an error occurs.
  @Deprecated('This method has been deprecated. Please use [updatePreferences] instead.')
  static Future<PushPreferences?> updatePushPreferences(
      final PushPreferences pushPreferences,
      {Function(PushPreferences pushPreferences)? onSuccess,
      Function(CometChatException e)? onError}) async {
    try {
      final result = await channel.invokeMethod(
          'updatePreferences', pushPreferences.toMap());
      final pushPreferencesObj = PushPreferences.fromMap(result);
      if (onSuccess != null) onSuccess(pushPreferencesObj);
      return pushPreferencesObj;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Resets push notification preferences to their default values for the logged-in user.
  ///
  /// This method makes an asynchronous call to the CometChat server to reset the [PushPreferences].
  /// Upon successful reset, [onSuccess] is invoked with the reset [PushPreferences] object.
  /// If an error occurs, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<PushPreferences?>] which completes with the reset preferences,
  /// or null if an error occurs.
  @Deprecated('This method has been deprecated. Please use [resetPreferences] instead.')
  static Future<PushPreferences?> resetPushPreferences(
      {Function(PushPreferences pushPreferences)? onSuccess,
      Function(CometChatException e)? onError}) async {
    try {
      final result = await channel.invokeMethod('resetPreferences');
      final pushPreferencesObj = PushPreferences.fromMap(result);
      if (onSuccess != null) onSuccess(pushPreferencesObj);
      return pushPreferencesObj;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Retrieves a list of conversations that have been muted by the logged-in user.
  ///
  /// This method makes an asynchronous call to the CometChat server to fetch all muted conversations.
  /// Upon successful retrieval, [onSuccess] is invoked with a list of [MutedConversation] objects.
  /// If an error occurs, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<List<MutedConversation>>] which completes with the list of muted conversations,
  /// or an empty list if an error occurs.
  static Future<List<MutedConversation>> getMutedConversations(
      {Function(List<MutedConversation> mutedConversations)? onSuccess,
      Function(CometChatException e)? onError}) async {
    List<MutedConversation> mutedConversations = [];
    try {
      final result = await channel.invokeMethod('getMutedConversations');
      Map<dynamic, dynamic> map = result;
      map.forEach((key, value) {
        mutedConversations.add(MutedConversation.fromMap(value));
      });
      if (onSuccess != null) onSuccess(mutedConversations);
      return mutedConversations;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return mutedConversations;
  }

  /// Mutes the specified conversations for the logged-in user.
  ///
  /// This method asynchronously sends a request to the CometChat server to mute the provided list of conversations.
  /// Upon a successful mute operation, [onSuccess] is invoked with a success response.
  /// If an error occurs, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<String?>] which completes with a success response if the operation is successful,
  /// or null if an error occurs.
  static Future<String?> muteConversations(
      List<MutedConversation> muteConversations,
      {Function(String response)? onSuccess,
      Function(CometChatException e)? onError}) async {
    try {
      Map<int, dynamic> map = <int, dynamic>{};
      for (int i = 0; i < muteConversations.length; i++) {
        map[i] = muteConversations[i].toMap();
      }
      final result = await channel.invokeMethod('muteConversations', map);
      if (onSuccess != null) onSuccess(result);
      return result;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Unmutes the specified conversations for the logged-in user.
  ///
  /// This method asynchronously sends a request to the CometChat server to unmute the provided list of conversations.
  /// Upon a successful unmute operation, [onSuccess] is invoked with a success response.
  /// If an error occurs, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<String?>] which completes with a success response if the operation is successful,
  /// or null if an error occurs.
  static Future<String?> unmuteConversations(
      List<UnmutedConversation> unmutedConversations,
      {Function(String response)? onSuccess,
      Function(CometChatException e)? onError}) async {
    try {
      Map<int, dynamic> map = <int, dynamic>{};
      for (int i = 0; i < unmutedConversations.length; i++) {
        map[i] = unmutedConversations[i].toMap();
      }
      final result = await channel.invokeMethod('unmuteConversations', map);
      if (onSuccess != null) onSuccess(result);
      return result;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Registers a push notification token with the CometChat server for the current user.
  ///
  /// Depending on the provided [PushPlatforms], this method registers the appropriate token such as FCM token for Android and iOS,
  /// APNS device token, or APNS VOIP token for iOS.
  /// It requires at least one valid token to be provided based on the platform.
  /// If registration is successful, [onSuccess] is invoked with a success response.
  /// If an error occurs, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<String?>] that completes with a success response if the operation is successful,
  /// or null if an error occurs.
  static Future<String?> registerPushToken(PushPlatforms pushPlatforms,
      {String? fcmToken,
      String? deviceToken,
      String? voipToken,
      String? providerId,
      Function(String response)? onSuccess,
      Function(CometChatException e)? onError}) async {
    try {
      if (pushPlatforms == PushPlatforms.FCM_FLUTTER_IOS ||
          pushPlatforms == PushPlatforms.FCM_FLUTTER_ANDROID) {
        if (Platform.isIOS &&
            pushPlatforms == PushPlatforms.FCM_FLUTTER_ANDROID) {
          _errorCallbackHandler(
              CometChatException(
                  CometChatNotificationErrorCode.ERROR_INVALID_PUSH_PLATFORM,
                  CometChatNotificationErrorMessages
                      .ERROR_MESSAGE_INVALID_PUSH_PLATFORM,
                  CometChatNotificationErrorMessages
                      .ERROR_MESSAGE_INVALID_PUSH_PLATFORM),
              null,
              null,
              onError);
          return null;
        } else {
          if (fcmToken == null) {
            _errorCallbackHandler(
                CometChatException(
                    CometChatNotificationErrorCode.ERROR_INVALID_FCM_TOKEN,
                    CometChatNotificationErrorMessages
                        .ERROR_MESSAGE_INVALID_FCM_TOKEN,
                    CometChatNotificationErrorMessages
                        .ERROR_MESSAGE_INVALID_FCM_TOKEN),
                null,
                null,
                onError);
            return null;
          }
        }
      } else if (pushPlatforms == PushPlatforms.APNS_FLUTTER_DEVICE) {
        if (deviceToken == null) {
          _errorCallbackHandler(
              CometChatException(
                  CometChatNotificationErrorCode
                      .ERROR_INVALID_APNS_DEVICE_TOKEN,
                  CometChatNotificationErrorMessages
                      .ERROR_MESSAGE_APNS_INVALID_DEVICE_TOKEN,
                  CometChatNotificationErrorMessages
                      .ERROR_MESSAGE_APNS_INVALID_DEVICE_TOKEN),
              null,
              null,
              onError);
          return null;
        }
      } else if (pushPlatforms == PushPlatforms.APNS_FLUTTER_VOIP) {
        if (voipToken == null) {
          _errorCallbackHandler(
              CometChatException(
                  CometChatNotificationErrorCode.ERROR_INVALID_APNS_VOIP_TOKEN,
                  CometChatNotificationErrorMessages
                      .ERROR_MESSAGE_APNS_INVALID_VOIP_TOKEN,
                  CometChatNotificationErrorMessages
                      .ERROR_MESSAGE_APNS_INVALID_VOIP_TOKEN),
              null,
              null,
              onError);
          return null;
        }
      }
      final result = await channel.invokeMethod('registerPushToken', {
        "pushPlatforms": pushPlatforms.type,
        "fcmToken": fcmToken,
        "deviceToken": deviceToken,
        "voipToken": voipToken,
        "providerId": providerId
      });
      if (onSuccess != null) onSuccess(result);
      return result;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Unregisters the push notification token for the logged-in user.
  ///
  /// This method makes an asynchronous call to the CometChat server to remove the associated
  /// push notification token, thus preventing further push notifications from being sent to the user's device.
  /// Upon unregistering successfully, [onSuccess] is invoked with a confirmation response.
  /// If an error occurs, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<String?>] which completes with a confirmation response if the operation is successful,
  /// or null if an error occurs.
  static Future<String?> unregisterPushToken(
      {Function(String response)? onSuccess,
      Function(CometChatException e)? onError}) async {
    try {
      final result = await channel.invokeMethod('unregisterPushToken');
      if (onSuccess != null) onSuccess(result);
      return result;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  static _errorCallbackHandler(CometChatException? cce, PlatformException? p,
      Object? e, Function(CometChatException excep)? onError) {
    if (onError != null) {
      if (cce != null) {
        onError(cce);
      } else if (p != null) {
        onError(CometChatException(p.code, p.details, p.message));
      } else if (e != null) {
        onError(CometChatException(
            ErrorCode.errorUnhandledException, e.toString(), e.toString()));
      }
    } else {
      debugPrint(
          "Error: CometChatException: $cce --- PlatformException = $p --- Exception: $e");
    }
  }

  /// Retrieves the current notification preferences for the logged-in user.
  ///
  /// This method makes an asynchronous call to fetch the [NotificationPreferences] from CometChat servers.
  /// Upon successful retrieval, [onSuccess] is invoked with the [NotificationPreferences] object.
  /// In the case of an error, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<NotificationPreferences?>] which completes with the fetched preferences,
  /// or null if an error occurs.
  static Future<NotificationPreferences?> fetchPreferences(
      {Function(NotificationPreferences notificationPreferences)? onSuccess,
        Function(CometChatException e)? onError}) async {
    try {
      final result = await channel.invokeMethod('fetchPreferences');
      final notificationPreferencesObj = NotificationPreferences.fromMap(result);
      if (onSuccess != null) onSuccess(notificationPreferencesObj);
      return notificationPreferencesObj;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Updates the notification preferences for the logged-in user.
  ///
  /// This method asynchronously sends the updated [NotificationPreferences] to the CometChat server.
  /// If the update is successful, [onSuccess] is called with the updated [NotificationPreferences] object.
  /// If an error occurs during the update, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<NotificationPreferences?>] that resolves to the updated preferences, or null if an error occurs.
  static Future<NotificationPreferences?> updatePreferences(
      final NotificationPreferences notificationPreferences,
      {Function(NotificationPreferences notificationPreferences)? onSuccess,
        Function(CometChatException e)? onError}) async {
    try {
      final result = await channel.invokeMethod(
          'updatePreferences', notificationPreferences.toMap());
      final notificationPreferencesObj = NotificationPreferences.fromMap(result);
      if (onSuccess != null) onSuccess(notificationPreferencesObj);
      return notificationPreferencesObj;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Resets notification preferences to their default values for the logged-in user.
  ///
  /// This method makes an asynchronous call to the CometChat server to reset the [NotificationPreferences].
  /// Upon successful reset, [onSuccess] is invoked with the reset [NotificationPreferences] object.
  /// If an error occurs, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<NotificationPreferences?>] which completes with the reset preferences,
  /// or null if an error occurs.
  static Future<NotificationPreferences?> resetPreferences(
      {Function(NotificationPreferences notificationPreferences)? onSuccess,
        Function(CometChatException e)? onError}) async {
    try {
      final result = await channel.invokeMethod('resetPreferences');
      final notificationPreferencesObj = NotificationPreferences.fromMap(result);
      if (onSuccess != null) onSuccess(notificationPreferencesObj);
      return notificationPreferencesObj;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Updates the timezone preference for the logged-in user.
  ///
  /// This method makes an asynchronous call to the CometChat server to update the timezone preference for the logged-in user.
  /// Upon successful update, [onSuccess] is invoked with a success response.
  /// If an error occurs, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<String>], which completes with a success response if the operation is successful,
  /// or null if an error occurs.
  static Future<String?> updateTimezone(String timezone,{Function(String response)? onSuccess,
    Function(CometChatException e)? onError}) async {
    if(timezone.isEmpty){
      _errorCallbackHandler(CometChatException(ErrorCode.errorInvalidTimezone, ErrorMessage.errorInvalidEmptyTimezone, ErrorMessage.errorInvalidEmptyTimezone), null, null, onError);
      return null;
    }

    try {
      final result = await channel.invokeMethod('updateTimezone', {"timezone":timezone});
      if (onSuccess != null) onSuccess(result);
      return result;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

  /// Retrieves the timezone preference for the logged-in user.
  ///
  /// This method makes an asynchronous call to the CometChat server to fetch the timezone preference for the logged-in user.
  /// Upon successful retrieval, [onSuccess] is invoked with the timezone preference.
  /// If an error occurs, [onError] is called with a [CometChatException].
  ///
  /// Returns a [Future<String?>], which completes with the timezone preference if the operation is successful,
  /// or null if an error occurs.
  static Future<String?> getTimezone({Function(String response)? onSuccess,
    Function(CometChatException e)? onError}) async {
    try {
      final result = await channel.invokeMethod('getTimezone');
      if (onSuccess != null) onSuccess(result);
      return result;
    } on PlatformException catch (p) {
      _errorCallbackHandler(null, p, null, onError);
    } catch (e) {
      _errorCallbackHandler(null, null, e, onError);
    }
    return null;
  }

}
