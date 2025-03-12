import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_app/app/routes/app_pages.dart';
import 'package:portfolio_app/app/routes/app_routes.dart';

class AppWidget extends StatelessWidget {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  AppWidget({super.key}) {
    Get.put<RouteObserver<PageRoute>>(routeObserver);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Portfólio Mobile',
      locale: Locale('pt', 'BR'),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.INITIAL,
      fallbackLocale: Locale('pt', 'BR'),
      navigatorObservers: [routeObserver],
    );
  }
}
