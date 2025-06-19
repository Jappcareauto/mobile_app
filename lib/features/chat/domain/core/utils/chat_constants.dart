//Don't translate me
class ChatConstants {
  static const String featureName = 'chat';
  static const String featureVersion = '1.0.0';
  static const String chatUri =
      'https://bpi.jappcare.com/api/v1/chat?chatRoomId=';

  static const String chatWebsocketUri = 'https://bpi.jappcare.com/ws';
  static const String chatRoomTopic = '/topic/chatroom';
  static const String chatMessageDestination = '/app/chat/message';

  static const String sendMessagePostUri = '/chat-message';

  static const String getAllChatRoomUri = '/chatroom/list';
  static const String getAllChatRoomMessagesUri = '/chat/message/chatroom';
  static const String getAllUserChatRoomsUri = '/chatroom/user';
  static const String getChatRoomByAppointmentIdUri = '/chatroom/appointment';
  // Add other constants here
}
