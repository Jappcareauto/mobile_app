//Don't translate me
class ChatConstants {
  static const String featureName = 'chat';
  static const String featureVersion = '1.0.0';
  static const String chatUri =
      'https://bpi.jappcare.com/api/v1/chat?chatRoomId=';

  // Production WebSocket URL with explicit :443 port
  // (stomp_dart_client requires explicit port to avoid port:0 bug)
  static const String chatWebsocketUri = 'https://bpi.jappcare.com:443/ws';

  // WebSocket STOMP destinations
  static const String chatRoomTopic =
      '/topic/chat'; // Subscribe: /topic/chat/{chatId}
  static const String chatMessageDestination =
      '/app/chat'; // Send: /app/chat/{chatId}/sendMessage
  static const String chatDeliveryTopic =
      '/topic/chat'; // Delivery: /topic/chat/{chatId}/delivery

  // REST API endpoints
  static const String sendMessagePostUri =
      '/chat'; // POST /chat/{chatId}/sendMessage/other
  static const String getAllChatRoomUri = '/chatroom/list';
  static const String getAllChatRoomMessagesUri = '/chat/message/chatroom';
  static const String getAllUserChatRoomsUri = '/chatroom/user';
  static const String getChatRoomByAppointmentIdUri = '/chatroom/appointment';
  static const String createChatRoomUri = '/chatroom';
  static const String getChatRoomByIdUri = '/chatroom';
  // Add other constants here
}
