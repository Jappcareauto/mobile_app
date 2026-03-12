import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';

abstract class ChatListItem {}

class DateHeaderItem extends ChatListItem {
  final String date;
  DateHeaderItem(this.date);
}

class MessageItem extends ChatListItem {
  final ChatMessageEntity message;
  MessageItem(this.message);
}

class AppointmentItem extends ChatListItem {
  final AppointmentEntity appointment;
  AppointmentItem(this.appointment);
}
