import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';

class TipModalBottomWidget extends StatelessWidget {
  const TipModalBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: 370,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Tip",
                style: Get.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(
                "Rotate your tires regularly to ensure they wear evenly and last longer.",
                style: Get.textTheme.bodyMedium?.copyWith(
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(
                "Regularly rotating your tires is essential for maintaining even wear and extending their lifespan. By rotating your tires consistently, you can help distribute the wear more evenly across all four tires, resulting in a longer lifespan for each tire. This practice not only promotes safety but also helps you get the most out of your investment in tires.",
                style: Get.textTheme.bodyMedium),
            const SizedBox(height: 20),
            CustomButton(text: "Done", onPressed: Get.back),
          ],
        ));
  }
}
