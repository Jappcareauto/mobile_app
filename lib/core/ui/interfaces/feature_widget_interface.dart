import 'package:flutter/material.dart';

abstract class FeatureWidgetInterface {
  Widget buildView([dynamic args]);
  void refreshData();
  // String get name;
}
