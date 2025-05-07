import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:To3maa/core/di/di.dart';
import 'package:To3maa/core/router/app_router.dart';
import 'package:To3maa/core/shared/style/app_theme.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/style/app_colors.dart';
import 'core/preferences/app_pref.dart';
import 'core/shared/constant/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator().init();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // runApp(DevicePreview(builder: (context) => const MyApp()));
  runApp(EasyLocalization(
      supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALISATIONS,
      child: Phoenix(child: const MyApp())));

  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                children: [
                   Text(
                    AppStrings.someThingWentWrong.tr(),
                    style: const TextStyle(color: AppColors.cPrimary),
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = sl<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName.tr(),
              builder: EasyLoading.init(),
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: Routes.homeRoute,
              theme: AppTheme.lightTheme);
        });
  }
}
