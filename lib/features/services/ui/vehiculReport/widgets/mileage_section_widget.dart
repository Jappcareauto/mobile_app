import 'package:flutter/material.dart';
import 'package:jappcare/features/services/ui/vehiculReport/widgets/chart_container_widgets.dart';
import 'package:jappcare/features/services/ui/vehiculReport/widgets/warning_container.dart';

class MileageSectionWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mileage',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 10),
          WarningContainer(title: 'Beware', text: 'This vehicle may have a fake mileage'),
          ChartContainerWidgets()
        ],
      ),
    );
  }

}