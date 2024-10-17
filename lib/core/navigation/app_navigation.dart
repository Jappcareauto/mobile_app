import 'package:flutter/material.dart';

abstract class AppNavigation {
  Future<void>? toNamed(String routeName, {dynamic arguments});
  Future<void>? to(Widget page, {dynamic arguments});
  Future<void>? toNamedAndReplace(String routeName, {dynamic arguments});
  Future<void>? toNamedAndReplaceAll(String routeName, {dynamic arguments});
  void goBack<T>({T? result});
}