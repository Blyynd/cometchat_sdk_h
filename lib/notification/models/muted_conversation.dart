import '../../cometchat_sdk.dart';

class MutedConversation {
  String? id;
  MutedConversationType? type;
  num? until;

  MutedConversation({this.id, this.type, this.until});

  MutedConversation.fromMap(dynamic map) {
    id = map['id'];
    type = MutedConversationType.fromValue(map['type']);
    until = map['until'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (type != null) {
      data['type'] = type?.type;
    }
    if (until != null) {
      data['until'] = until;
    }
    return data;
  }
}
