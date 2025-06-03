import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/services/ui/vehicleReport/controllers/vehicle_report_controller.dart';
import 'package:jappcare/features/services/ui/vehicleReport/widgets/damage_widgets.dart';
import 'package:jappcare/features/services/ui/vehicleReport/widgets/mileage_section_widget.dart';

class CardDetailsWidget extends GetView<VehicleReportController> {
  const CardDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int selectedIndex = controller.selectedFilter.value;
      if (selectedIndex == 4) {
        return const MileageSectionWidget();
      }
      if (selectedIndex == 5) {
        return const Column(
          children: [
            DamageWidgets(
              cause: 'Unknown',
              estimPrice: '3000 - 5000',
              status: 'Damaged',
            ),
            SizedBox(
              height: 20,
            ),
            DamageWidgets(
              cause: 'Unknown',
              estimPrice: '3000 - 5000',
              status: 'Damaged',
            )
          ],
        );
      }
      // Si "Overview" est sélectionné (index = 0)
      if (selectedIndex == 0) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.details.keys.map((sectionTitle) {
                List<Map<String, String>> sectionData =
                    controller.details[sectionTitle] ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre de la section
                    Text(
                      sectionTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Cartes de données de la section
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: sectionData.map((item) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 2 - 40,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.2),
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.keys.first, // Titre (ex: Make)
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.values.first, // Valeur (ex: Porsche)
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),
                    const MileageSectionWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    const DamageWidgets(
                      cause: 'Unknown',
                      estimPrice: '3000 - 5000',
                      status: 'Damaged',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DamageWidgets(
                      cause: 'Unknown',
                      estimPrice: '3000 - 5000',
                      status: 'Damaged',
                    )
                  ],
                );
              }).toList(),
            ),
          ),
        );
      }

      // Si un autre tag est sélectionné
      String selectedTag = controller.texts[selectedIndex];
      List<Map<String, String>> data = controller.details[selectedTag] ?? [];

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre de la section
              Text(
                selectedTag,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),

              // Cartes des données
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: data.map((item) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.keys.first,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.values.first,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
