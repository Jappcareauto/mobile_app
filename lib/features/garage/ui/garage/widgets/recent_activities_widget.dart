import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../../core/ui/widgets/custom_tab_bar.dart';
import 'car_card_widget.dart';

class RecentActivitiesWidget extends StatelessWidget
    implements FeatureWidgetInterface {
  final bool haveTitle;
  final bool haveTabBar;
  const RecentActivitiesWidget(
      {super.key, this.haveTitle = true, this.haveTabBar = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (haveTitle)
          Text(
            "Recent Activities",
            style:
                Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        if (haveTitle) const SizedBox(height: 15),
        if (haveTabBar)
          CustomTabBar(
            labels: const ["All", "Ongoing", "Completed"],
            onTabSelected: (index) {},
          ),
        if (haveTabBar) const SizedBox(height: 20),
        const Column(children: [
          CarCardWidget(
            date: '02/02/23',
            time: '00:02',
            localisation: 'Yaoundé',
            nameCar: 'Turbo Moteur',
            pathImageCar:
                'https://s3-alpha-sig.figma.com/img/1a76/2a6f/5e8173900d54188840dcc505afaab0b3?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rub6vLCB3USasOCi8DKeP~0uJcH131QNXWNteLu00apeGOD2N4Nzb1aNIqeMh~0DHvoJA8N2j5ekuCKwFGpW31N9IDWtAOur5zTByAEX66zsr2eALqm5ra1i1l7cIoPG8JbwegYa3a1eN72m59UJGaCzo7b2TM~rVVvN2Pign1rgPAEHppzwnmeGQaaDkf2vf-xR5WSqmbuMPP3pLOG8j9YxoHMgIdzKExKghycrIoEnL3-FqgCXW4lbnIWNhw06iD7toWwFgKjQuYexAcFh-S~CfuTz8cUq7bhh7cyEx8zRuRhvaFgLixqymuCwqxMbPGFop3t1PUWaw5OWVAfajw__',
            status: 'Completed',
          ),
          CarCardWidget(
            date: '02/02/23',
            time: '00:02',
            localisation: 'Yaoundé',
            nameCar: 'Turbo Moteur',
            pathImageCar:
                'https://s3-alpha-sig.figma.com/img/1a76/2a6f/5e8173900d54188840dcc505afaab0b3?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rub6vLCB3USasOCi8DKeP~0uJcH131QNXWNteLu00apeGOD2N4Nzb1aNIqeMh~0DHvoJA8N2j5ekuCKwFGpW31N9IDWtAOur5zTByAEX66zsr2eALqm5ra1i1l7cIoPG8JbwegYa3a1eN72m59UJGaCzo7b2TM~rVVvN2Pign1rgPAEHppzwnmeGQaaDkf2vf-xR5WSqmbuMPP3pLOG8j9YxoHMgIdzKExKghycrIoEnL3-FqgCXW4lbnIWNhw06iD7toWwFgKjQuYexAcFh-S~CfuTz8cUq7bhh7cyEx8zRuRhvaFgLixqymuCwqxMbPGFop3t1PUWaw5OWVAfajw__',
            status: 'In Progress',
          ),
          CarCardWidget(
            date: '02/02/23',
            time: '00:02',
            localisation: 'Yaoundé',
            nameCar: 'Turbo Moteur',
            pathImageCar:
                'https://s3-alpha-sig.figma.com/img/1a76/2a6f/5e8173900d54188840dcc505afaab0b3?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rub6vLCB3USasOCi8DKeP~0uJcH131QNXWNteLu00apeGOD2N4Nzb1aNIqeMh~0DHvoJA8N2j5ekuCKwFGpW31N9IDWtAOur5zTByAEX66zsr2eALqm5ra1i1l7cIoPG8JbwegYa3a1eN72m59UJGaCzo7b2TM~rVVvN2Pign1rgPAEHppzwnmeGQaaDkf2vf-xR5WSqmbuMPP3pLOG8j9YxoHMgIdzKExKghycrIoEnL3-FqgCXW4lbnIWNhw06iD7toWwFgKjQuYexAcFh-S~CfuTz8cUq7bhh7cyEx8zRuRhvaFgLixqymuCwqxMbPGFop3t1PUWaw5OWVAfajw__',
            status: 'Completed',
          ),
        ])
      ],
    );
  }

  @override
  Widget buildView([args]) {
    if (args != null && args is bool) {
      return RecentActivitiesWidget(haveTabBar: args);
    } else {
      return this;
    }
  }
}
