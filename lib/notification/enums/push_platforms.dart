enum PushPlatforms {
  FCM_FLUTTER_ANDROID('fcm_flutter_android'),
  FCM_FLUTTER_IOS('fcm_flutter_ios'),
  APNS_FLUTTER_DEVICE('apns_flutter_device'),
  APNS_FLUTTER_VOIP('apns_flutter_voip');

  final String type;

  const PushPlatforms(this.type);

  @override
  String toString() => type.toString();

  static PushPlatforms? fromValue(String value) {
    for (final option in PushPlatforms.values) {
      if (option.type == value) {
        return option;
      }
    }
    return null;
  }
}
