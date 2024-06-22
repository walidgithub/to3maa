import 'package:flutter/material.dart';
import 'package:flutter_laravel/flutter_and_laravel_demo/presentation/ui/home_page/home_page_view.dart';
import 'arguments.dart';
class Routes {
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePageView());
      // case Routes.surahRoute:
      //   return MaterialPageRoute(builder: (_) => SurahView(initialPage: settings.arguments as GoToPage));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Container()),
            );
  }
}
