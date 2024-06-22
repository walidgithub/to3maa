import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_laravel/flutter_and_laravel_demo/presentation/di/di.dart';
import 'package:flutter_laravel/flutter_and_laravel_demo/presentation/router/app_router.dart';
import 'package:flutter_laravel/flutter_and_laravel_demo/presentation/shared/constant/app_strings.dart';
import 'package:flutter_laravel/flutter_and_laravel_demo/presentation/ui/home_page/home_page_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'flutter_and_laravel_demo/presentation/shared/constant/app_constants.dart';
import 'flutter_and_laravel_demo/presentation/shared/style/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator().init();
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());

  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
    body: SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text(
                AppStrings.someThingWentWrong,
                style: TextStyle(color: AppColors.kPrimary),
              ),
              SizedBox(
                height: AppConstants.heightBetweenElements,
              ),
              Text(
                details.exceptionAsString(),
                style: const TextStyle(color: AppColors.kPrimary),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter And Laravel Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kPrimary),
          useMaterial3: true,
        ),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.homeRoute,
      ),
    );
  }
}