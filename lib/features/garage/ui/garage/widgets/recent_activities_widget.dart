import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';

import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../../core/ui/widgets/custom_tab_bar.dart';
import 'car_card_widget.dart';

class RecentActivitiesWidget extends StatelessWidget
    implements FeatureWidgetInterface {
  final String title;
  final bool haveTitle;
  final bool haveTabBar;
  final bool isHorizontal;
  final String? status;
  const RecentActivitiesWidget(
      {super.key,
      this.title = "Recent Activities",
      this.haveTitle = true,
      this.haveTabBar = true,
      this.isHorizontal = false,
      this.status});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GarageController>(
      init: GarageController(Get.find()),
      initState: (_) {},
      builder: (_) {
        var ws = [
          CarCardWidget(
            date: '02/02/23',
            time: '00:02',
            localisation: 'Yaoundé',
            nameCar: 'Turbo Moteur',
            pathImageCar:
                'https://s3-alpha-sig.figma.com/img/1a76/2a6f/5e8173900d54188840dcc505afaab0b3?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rub6vLCB3USasOCi8DKeP~0uJcH131QNXWNteLu00apeGOD2N4Nzb1aNIqeMh~0DHvoJA8N2j5ekuCKwFGpW31N9IDWtAOur5zTByAEX66zsr2eALqm5ra1i1l7cIoPG8JbwegYa3a1eN72m59UJGaCzo7b2TM~rVVvN2Pign1rgPAEHppzwnmeGQaaDkf2vf-xR5WSqmbuMPP3pLOG8j9YxoHMgIdzKExKghycrIoEnL3-FqgCXW4lbnIWNhw06iD7toWwFgKjQuYexAcFh-S~CfuTz8cUq7bhh7cyEx8zRuRhvaFgLixqymuCwqxMbPGFop3t1PUWaw5OWVAfajw__',
            status: 'Completed',
            onPressed: _.goToVehicleDetails,
          ),
          CarCardWidget(
            date: '02/02/23',
            time: '00:02',
            localisation: 'Yaoundé',
            nameCar: 'Turbo Moteur',
            pathImageCar:
                'https://s3-alpha-sig.figma.com/img/1a76/2a6f/5e8173900d54188840dcc505afaab0b3?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rub6vLCB3USasOCi8DKeP~0uJcH131QNXWNteLu00apeGOD2N4Nzb1aNIqeMh~0DHvoJA8N2j5ekuCKwFGpW31N9IDWtAOur5zTByAEX66zsr2eALqm5ra1i1l7cIoPG8JbwegYa3a1eN72m59UJGaCzo7b2TM~rVVvN2Pign1rgPAEHppzwnmeGQaaDkf2vf-xR5WSqmbuMPP3pLOG8j9YxoHMgIdzKExKghycrIoEnL3-FqgCXW4lbnIWNhw06iD7toWwFgKjQuYexAcFh-S~CfuTz8cUq7bhh7cyEx8zRuRhvaFgLixqymuCwqxMbPGFop3t1PUWaw5OWVAfajw__',
            status: 'In Progress',
            onPressed: _.goToVehicleDetails,
          ),
          CarCardWidget(
            date: '02/02/23',
            time: '00:02',
            localisation: 'Yaoundé',
            nameCar: 'Turbo Moteur',
            pathImageCar:
                'https://s3-alpha-sig.figma.com/img/1a76/2a6f/5e8173900d54188840dcc505afaab0b3?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rub6vLCB3USasOCi8DKeP~0uJcH131QNXWNteLu00apeGOD2N4Nzb1aNIqeMh~0DHvoJA8N2j5ekuCKwFGpW31N9IDWtAOur5zTByAEX66zsr2eALqm5ra1i1l7cIoPG8JbwegYa3a1eN72m59UJGaCzo7b2TM~rVVvN2Pign1rgPAEHppzwnmeGQaaDkf2vf-xR5WSqmbuMPP3pLOG8j9YxoHMgIdzKExKghycrIoEnL3-FqgCXW4lbnIWNhw06iD7toWwFgKjQuYexAcFh-S~CfuTz8cUq7bhh7cyEx8zRuRhvaFgLixqymuCwqxMbPGFop3t1PUWaw5OWVAfajw__',
            status: 'Completed',
            onPressed: _.goToVehicleDetails,
          ),
          CarCardWidget(
            date: '02/02/23',
            time: '00:02',
            localisation: 'Yaoundé',
            nameCar: 'Turbo Moteur',
            pathImageCar:
                'https://s3-alpha-sig.figma.com/img/1a76/2a6f/5e8173900d54188840dcc505afaab0b3?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rub6vLCB3USasOCi8DKeP~0uJcH131QNXWNteLu00apeGOD2N4Nzb1aNIqeMh~0DHvoJA8N2j5ekuCKwFGpW31N9IDWtAOur5zTByAEX66zsr2eALqm5ra1i1l7cIoPG8JbwegYa3a1eN72m59UJGaCzo7b2TM~rVVvN2Pign1rgPAEHppzwnmeGQaaDkf2vf-xR5WSqmbuMPP3pLOG8j9YxoHMgIdzKExKghycrIoEnL3-FqgCXW4lbnIWNhw06iD7toWwFgKjQuYexAcFh-S~CfuTz8cUq7bhh7cyEx8zRuRhvaFgLixqymuCwqxMbPGFop3t1PUWaw5OWVAfajw__',
            status: 'In Progress',
            onPressed: _.goToVehicleDetails,
          ),
          CarCardWidget(
            date: '02/02/23',
            time: '00:02',
            localisation: 'Yaoundé',
            nameCar: 'Turbo Moteur',
            pathImageCar:
                'https://s3-alpha-sig.figma.com/img/1a76/2a6f/5e8173900d54188840dcc505afaab0b3?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rub6vLCB3USasOCi8DKeP~0uJcH131QNXWNteLu00apeGOD2N4Nzb1aNIqeMh~0DHvoJA8N2j5ekuCKwFGpW31N9IDWtAOur5zTByAEX66zsr2eALqm5ra1i1l7cIoPG8JbwegYa3a1eN72m59UJGaCzo7b2TM~rVVvN2Pign1rgPAEHppzwnmeGQaaDkf2vf-xR5WSqmbuMPP3pLOG8j9YxoHMgIdzKExKghycrIoEnL3-FqgCXW4lbnIWNhw06iD7toWwFgKjQuYexAcFh-S~CfuTz8cUq7bhh7cyEx8zRuRhvaFgLixqymuCwqxMbPGFop3t1PUWaw5OWVAfajw__',
            status: 'In Progress',
            onPressed: _.goToVehicleDetails,
          ),
        ];
        if (status != null) {
          ws = ws.where((w) => w.status == status).toList();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (haveTitle)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            if (haveTitle) const SizedBox(height: 15),
            if (haveTabBar)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomTabBar(
                  labels: const ["All", "Ongoing", "Completed"],
                  onTabSelected: (index) {},
                ),
              ),
            if (haveTabBar) const SizedBox(height: 20),
            isHorizontal
                ? SizedBox(
                    height: 220,
                    child: ListView(
                        scrollDirection: Axis.horizontal, children: ws))
                : Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(children: ws),
                  )
          ],
        );
      },
    );
  }

  @override
  Widget buildView([args]) {
    if (args != null && args is bool) {
      return RecentActivitiesWidget(haveTabBar: args);
    } else if (args != null && args is String) {
      return RecentActivitiesWidget(
        title: args,
      );
    } else if (args != null && args is Map) {
      return RecentActivitiesWidget(
        haveTabBar: args['haveTabBar'] ?? true,
        haveTitle: args['haveTitle'] ?? true,
        title: args['title'] ?? 'Recent Activities',
        isHorizontal: args['isHorizontal'] ?? false,
        status: args['status'],
      );
    } else {
      return this;
    }
  }
}
