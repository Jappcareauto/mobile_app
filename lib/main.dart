import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:jappcare/core/themes/theme_controller.dart';
import 'package:jappcare/core/themes/theme_dark.dart';
import 'package:jappcare/core/themes/theme_light.dart';
import 'package:jappcare/generated/locales.g.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:jappcare/core/navigation/routes/app_pages.dart';
import 'core/navigation/routes/app_routes.dart';
import 'core/dependences/app_dependences.dart';

void main() async {
  await AppDependency.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(Main(AppRoutes.initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    final _themeController = Get.put(ThemeController());
    return ThemeProvider(
        initTheme: AppThemeLight.theme,
        builder: (context, myTheme) {
          return GetMaterialApp(
              builder: (context, child) => ResponsiveBreakpoints.builder(
                    child: child!,
                    breakpoints: [
                      const Breakpoint(start: 0, end: 450, name: MOBILE),
                      const Breakpoint(start: 451, end: 800, name: TABLET),
                      const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                      const Breakpoint(
                          start: 1921,
                          end: double.infinity,
                          name: "4K"), //Don't translate line
                    ],
                  ),
              debugShowCheckedModeBanner: false,
              title: "Jappcare",
              initialRoute: initialRoute,
              getPages: Get.find<AppPages>().getAllPages(),
              theme: myTheme,
              darkTheme: AppThemeDark.theme,
              themeMode: _themeController.themeMode.value,
              locale: const Locale('fr'), //Don't translate line
              translationsKeys: AppTranslation.translations);
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
