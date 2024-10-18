import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class EarningsGraph extends StatelessWidget {
  final double totalEarnings;
  final List<FlSpot> dataPoints;
  final String selectedPointLabel;
  final double selectedPointValue;
  final bool haveTitle;

  const EarningsGraph({
    Key? key,
    required this.totalEarnings,
    required this.dataPoints,
    required this.selectedPointLabel,
    required this.selectedPointValue,
    this.haveTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (haveTitle)
          Text(
            "Expenditure",
            style: Get.textTheme.bodyLarge,
          ),
        if (haveTitle) const SizedBox(width: 8),
        Text(
          '${totalEarnings.toStringAsFixed(0)} FCFA',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Get.theme.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.lightBorder)),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        axisNameSize: 2,
                        axisNameWidget: Container(),
                        drawBelowEverything: false,
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 25,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 1:
                                return const Text('1 Oct');
                              case 31:
                                return const Text('31 Oct');
                              default:
                                return Container();
                            }
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                          spots: dataPoints,
                          isCurved: true,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(
                              show: true,
                              color: Get.theme.primaryColor.withOpacity(0.1),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Get.theme.scaffoldBackgroundColor
                                        .withOpacity(.1),
                                    Get.theme.primaryColor.withOpacity(.4)
                                  ])),
                          barWidth: 1,
                          color: Get.theme.primaryColor),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        selectedPointLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'This Month',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
