import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_delete_button.dart';
import '../controllers/garage_controller.dart';

class DeleteVehicleWidget extends StatelessWidget {
  // final ChatController chatController = Get.put(ChatController(Get.find()));
  final VoidCallback onConfirm;
  const DeleteVehicleWidget({super.key, required this.onConfirm});
  @override
  Widget build(BuildContext context) {
    final garageController = Get.find<GarageController>();

    return Center(
      child: SizedBox(
        height: 150,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(
              child: Text(
                'Are you sure you want to delete this vehicle ?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                softWrap: false,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onPressed: () => Get.back(),
                    haveBorder: true,
                    strech: false,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomDeleteButton(
                    text: 'Confirm',
                    onPressed: () => onConfirm(),
                    color: Colors.red,
                    // chatController.goToAddPaymentMethodForm(
                    //     chatController.selectedMethod.value),
                    strech: false,
                    isLoading: garageController.vehicleDeleteLoading,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
