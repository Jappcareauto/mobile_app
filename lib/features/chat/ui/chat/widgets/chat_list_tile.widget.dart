import 'package:flutter/material.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';
import 'package:jappcare/core/ui/widgets/custom_avatar.widget.dart';

class ChatListTile extends StatelessWidget {
  final ChatRoomEntity chat;
  final VoidCallback onTap;

  const ChatListTile({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          CustomAvatarWidget(
            name: "Sinet",
            haveName: false,
          ),
          // CircleAvatar(
          //   radius: 28,
          //   backgroundImage: NetworkImage(chat.avatarUrl),
          //   backgroundColor: Colors.grey[300],
          // ),
          if (true)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        "Sinet Akhi",
        style: TextStyle(
          fontWeight: 10 > 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        chat.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: 10 > 0 ? Colors.black87 : Colors.grey[600],
          fontWeight: 10 > 0 ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "3:32pm",
            style: TextStyle(
              color: 10 > 0 ? Theme.of(context).primaryColor : Colors.grey,
              fontSize: 12,
              fontWeight: 10 > 0 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          if (10 > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                (10).toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
