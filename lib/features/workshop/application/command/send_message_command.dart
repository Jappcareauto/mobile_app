class SendMessageCommand {
  final String senderId ;
  final String content ;
  final String chatRoomId ;
  final String timestamp;
  final String type;
  final String appointmentId ;
  SendMessageCommand({
    required this.appointmentId,
    required this.chatRoomId,
    required this.content,
    required this.type,
    required this.senderId,
    required this.timestamp
});
}