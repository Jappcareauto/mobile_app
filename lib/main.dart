import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jappcare/core/services/localServices/locale_service.dart';
import 'package:jappcare/core/themes/theme_controller.dart';
import 'package:jappcare/core/themes/theme_dark.dart';
import 'package:jappcare/core/themes/theme_light.dart';
import 'package:jappcare/generated/locales.g.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:jappcare/core/navigation/routes/app_pages.dart';
import 'core/navigation/routes/app_routes.dart';
import 'core/dependences/app_dependences.dart';
import 'core/utils/app_constants.dart';

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
    final ThemeController themeController = Get.put(ThemeController());

    // Resolve saved locale — fall back to French (primary audience)
    final String? savedLanguage =
        GetStorage().read(AppConstants.languageKey) as String?;
    final Locale initialLocale = savedLanguage != null
        ? languageNameToLocale(savedLanguage)
        : const Locale('fr');

    return ThemeProvider(
        initTheme: AppThemeLight.theme,
        builder: (context, myTheme) {
          return GetMaterialApp(
              scrollBehavior: const AppScrollBehavior(),
              builder: (context, child) {
                final Widget content = ResponsiveBreakpoints.builder(
                  child: child!,
                  breakpoints: [
                    const Breakpoint(start: 0, end: 450, name: MOBILE),
                    const Breakpoint(start: 451, end: 800, name: TABLET),
                    const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                    const Breakpoint(
                        start: 1921,
                        end: double.infinity,
                        name: '4K'), //Don't translate line
                  ],
                );
                return DismissKeyboardOnInteraction(child: content);
              },
              debugShowCheckedModeBanner: false,
              title: 'Jappcare',
              initialRoute: initialRoute,
              getPages: Get.find<AppPages>().getAllPages(),
              theme: myTheme,
              darkTheme: AppThemeDark.theme,
              themeMode: themeController.currentTheme,
              locale: initialLocale,
              fallbackLocale: const Locale('fr'), //Don't translate line
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

class DismissKeyboardOnInteraction extends StatelessWidget {
  final Widget child;

  const DismissKeyboardOnInteraction({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  ScrollViewKeyboardDismissBehavior getKeyboardDismissBehavior(
      BuildContext context) {
    return ScrollViewKeyboardDismissBehavior.onDrag;
  }
}
