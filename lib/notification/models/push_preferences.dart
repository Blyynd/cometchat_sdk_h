import '../../cometchat_sdk.dart';

@Deprecated('This class has been deprecated. Please use [NotificationPreferences] instead.')
class PushPreferences {
  bool? usePrivacyTemplate = false;
  GroupPreferences? groupPreferences;
  MutePreferences? mutePreferences;
  OneOnOnePreferences? oneOnOnePreferences;

  PushPreferences(
      {this.usePrivacyTemplate,
      this.groupPreferences,
      this.mutePreferences,
      this.oneOnOnePreferences});

  PushPreferences.fromMap(dynamic map) {
    if (map['usePrivacyTemplate'] != null) {
      usePrivacyTemplate = map['usePrivacyTemplate'];
    }
    if (map['oneOnOnePreferences'] != null) {
      oneOnOnePreferences =
          OneOnOnePreferences.fromMap(map['oneOnOnePreferences']);
    }
    if (map['groupPreferences'] != null) {
      groupPreferences = GroupPreferences.fromMap(map['groupPreferences']);
    }
    if (map['mutePreferences'] != null) {
      mutePreferences = MutePreferences.fromMap(map['mutePreferences']);
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usePrivacyTemplate != null) {
      data['usePrivacyTemplate'] = usePrivacyTemplate;
    }
    if (oneOnOnePreferences != null) {
      data['oneOnOnePreferences'] = oneOnOnePreferences?.toMap();
    }
    if (groupPreferences != null) {
      data['groupPreferences'] = groupPreferences?.toMap();
    }
    if (mutePreferences != null) {
      data['mutePreferences'] = mutePreferences?.toMap();
    }
    return data;
  }
}
