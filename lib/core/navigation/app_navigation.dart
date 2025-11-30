import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

/// Abstract class for navigation in a Flutter application.
abstract class AppNavigation {
  /// Navigate to a named route in the app.
  ///
  /// [routeName] is the name of the route to navigate to.
  /// [arguments] is an optional parameter that can be used to pass data to the route.
  Future<void>? toNamed(String routeName, {dynamic arguments});

  /// Navigate to a specific widget in the app.
  ///
  /// [page] is the widget to navigate to.
  /// [arguments] is an optional parameter that can be used to pass data to the widget.
  Future<void>? to(Widget page, {Transition? transition, dynamic arguments});

  /// Navigate to a specific widget in the app.
  ///
  /// [page] is the widget to navigate to.
  /// [arguments] is an optional parameter that can be used to pass data to the widget.
  Future<void>? toWidget(Widget page,
      {Transition? transition, dynamic arguments});

  /// Navigate to a named route in the app, replacing the current route.
  ///
  /// [routeName] is the name of the route to navigate to.
  /// [arguments] is an optional parameter that can be used to pass data to the route.
  Future<void>? toNamedAndReplace(String routeName, {dynamic arguments});

  /// Navigate to a named route in the app, replacing all routes in the navigation stack.
  ///
  /// [routeName] is the name of the route to navigate to.
  /// [arguments] is an optional parameter that can be used to pass data to the route.
  Future<void>? toNamedAndReplaceAll(String routeName, {dynamic arguments});


  /// Navigate to a named route in the app, removing all routes in the navigation stack till the first route.
  ///
  /// [routeName] is the name of the route to navigate to.
  /// [arguments] is an optional parameter that can be used to pass data to the route.
  /// [parameters] is an optional parameter that can be used to pass query parameters to the route.
  Future<void>? toFirstAndPushNamed(
  String routeName, {
  dynamic arguments,
  Map<String, String>? parameters,
});

  /// Navigate to a named route in the app, replacing all routes in the navigation stack.
  ///
  /// [page] the widget to navigate to.
  /// [arguments] is an optional parameter that can be used to pass data to the route.
  Future<void>? toWidgetAndReplaceAll(Widget page,
      {Transition? transition, dynamic arguments});

  /// Go back to the previous route in the navigation stack.
  ///
  /// [result] is an optional parameter that can be used to pass data back to the previous route.
  void goBack<T>({T? result});
}
