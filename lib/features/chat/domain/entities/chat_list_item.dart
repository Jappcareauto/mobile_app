import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';

abstract class ChatListItem {}

class DateHeaderItem extends ChatListItem {
  final String date;
  DateHeaderItem(this.date);
}

class MessageItem extends ChatListItem {
  final ChatMessageEntity message;
  MessageItem(this.message);
}
