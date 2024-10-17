import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';

class AppBarWithAvatarAndSalutation extends StatelessWidget
    implements PreferredSizeWidget {
  final String userName;
  final String greetingMessage;

  const AppBarWithAvatarAndSalutation({
    Key? key,
    required this.userName,
    required this.greetingMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      // surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      toolbarHeight: 100,
      leadingWidth: 300,
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const HomeProfilScreen()),
                  // );
                },
                child: ImageComponent(
                  imageUrl: 'https://i.pravatar.cc/300',
                  width: 55,
                  height: 55,
                  borderRadius: 50,
                )),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  greetingMessage,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFFADAAAA),
                  ),
                ),
                Text(
                  userName,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              // Action à effectuer sur le clic
            },
            child: const Icon(
              FluentIcons.alert_24_regular,
              size: 30,
              color: Color.fromARGB(255, 167, 171, 184),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
