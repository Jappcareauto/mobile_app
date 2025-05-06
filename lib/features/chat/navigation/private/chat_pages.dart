import 'package:get/get.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/chat/chat_screen.dart';
import '../bindings/chat_controller_binding.dart';
import 'chat_private_routes.dart';

class ChatPages implements FeaturePages {
  @override
  List<GetPage> getPages() => [
        // GetPage(
        //   name: ChatPrivateRoutes.home,
        //   page: () => ChatScreen(),
        //   binding: ChatControllerBinding(),
        // ),
        GetPage(
          name: ChatPrivateRoutes.home,
          page: () => ChatDetailsScreen(),
          binding: ChatControllerBinding(),
        ),
        // Add other routes here
      ];
}
