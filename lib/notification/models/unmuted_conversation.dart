import '../../cometchat_sdk.dart';

class UnmutedConversation {
  String? id;
  MutedConversationType? type;

  UnmutedConversation({this.id, this.type});

  UnmutedConversation.fromMap(dynamic map) {
    id = map['id'];
    type = MutedConversationType.fromValue(map['type']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (type != null) {
      data['type'] = type?.type;
    }
    return data;
  }
}
