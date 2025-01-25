class SendMessage {

  final String senderId;
  final String content;
  final String chatRoomId;
  final String timestamp;
  final String type;
  final String appointmentId;

  SendMessage._({
    required this.senderId,
    required this.content,
    required this.chatRoomId,
    required this.timestamp,
    required this.type,
    required this.appointmentId,
  });

  factory SendMessage.create({
    required senderId,
    required content,
    required chatRoomId,
    required timestamp,
    required type,
    required appointmentId,
  }) {
    // Add any validation or business logic here
    return SendMessage._(
      senderId: senderId,
      content: content,
      chatRoomId: chatRoomId,
      timestamp: timestamp,
      type: type,
      appointmentId: appointmentId,
    );
  }

}
