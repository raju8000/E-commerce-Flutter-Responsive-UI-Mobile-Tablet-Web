import 'package:ecommerce_responsive/routes/route.dart';
import 'package:ecommerce_responsive/screens/screen_splash.dart';
import 'package:ecommerce_responsive/utils/scroll_behaviour.dart';
import 'package:ecommerce_responsive/utils/themes/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_store/app_store.dart';

AppStore appStore = AppStore();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'ShopX',
      scrollBehavior: AppScrollBehavior(),
      theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: ScreenSplash.tag,
      getPages: RouteGenerator.routes,
    );
  }
}

