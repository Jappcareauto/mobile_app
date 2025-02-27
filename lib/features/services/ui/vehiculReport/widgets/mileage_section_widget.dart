import 'package:flutter/material.dart';
import 'package:jappcare/features/services/ui/vehiculReport/widgets/chart_container_widgets.dart';
import 'package:jappcare/features/services/ui/vehiculReport/widgets/warning_container.dart';

class MileageSectionWidget extends StatelessWidget{
  const MileageSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mileage',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 10),
          WarningContainer(title: 'Beware', text: 'This vehicle may have a fake mileage'),
          ChartContainerWidgets()
        ],
      ),
    );
  }

}