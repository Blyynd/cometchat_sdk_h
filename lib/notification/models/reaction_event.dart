import '../../cometchat_sdk.dart';

class ReactionEvent {
  ReactionEvent(
      {this.reaction,
      this.receiverId,
      this.receiverType,
      this.conversationId,
      this.parentMessageId});

  final Reaction? reaction;

  final String? receiverId;

  final String? receiverType;

  final String? conversationId;

  final int? parentMessageId;

  factory ReactionEvent.fromMap(dynamic map) {
    if (map == null) {
      throw ArgumentError('The type of reaction event map is null');
    }
    return ReactionEvent(
      reaction:
          map['reaction'] != null ? Reaction.fromMap(map['reaction']) : null,
      receiverId: map['receiverId'] ?? '',
      receiverType: map['receiverType'] ?? '',
      conversationId: map['conversationId'] ?? '',
      parentMessageId: map['parentMessageId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reaction'] = this.reaction?.toJson();
    data['receiverId'] = this.receiverId;
    data['receiverType'] = this.receiverType;
    data['conversationId'] = this.conversationId;
    data['parentMessageId'] = this.parentMessageId;
    return data;
  }

  @override
  String toString() {
    return """
    ReactionEvent {
      reaction : $reaction,
      receiverId : $receiverId,
      receiverType : $receiverType,
      conversationId : $conversationId,
      parentMessageId : $parentMessageId
    }
    """;
  }
}
