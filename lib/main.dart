import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_laravel/zakat/presentation/di/di.dart';
import 'package:flutter_laravel/zakat/presentation/router/app_router.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_strings.dart';
import 'package:flutter_laravel/zakat/presentation/shared/style/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'zakat/presentation/shared/constant/app_constants.dart';
import 'zakat/presentation/shared/style/app_colors.dart';

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
                    style: TextStyle(color: AppColors.cPrimary),
                  ),
                  SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  Text(
                    details.exceptionAsString(),
                    style: const TextStyle(color: AppColors.cPrimary),
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
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Zakat',
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: Routes.homeRoute,
              theme: AppTheme.lightTheme);
        });
  }
}
