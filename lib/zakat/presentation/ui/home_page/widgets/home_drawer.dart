import 'package:To3maa/core/shared/constant/app_assets.dart';
import 'package:To3maa/core/shared/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/shared/constant/app_constants.dart';
import '../../../../../core/shared/constant/app_strings.dart';
import 'package:launch_app_store/launch_app_store.dart';
import 'dart:ui' as ui;

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cBackGround,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.all(10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.about.tr(),
                  style: TextStyle(color: AppColors.cBlack, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppStrings.info.tr(),
                  style: TextStyle(fontSize: 15.sp, color: AppColors.cNumber),textDirection: ui.TextDirection.rtl,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.evaluation.tr(),
                        style: TextStyle(color: AppColors.cBlack, fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: AppConstants.heightBetweenElements,
                      ),
                      Bounceable(
                        onTap: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 700));
                          LaunchReview.launch(
                              androidAppId: "com.To3maa.zakat"
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.rate,
                              width: 25.w,
                            ),
                            SvgPicture.asset(
                              AppAssets.rate,
                              width: 25.w,
                            ),
                            SvgPicture.asset(
                              AppAssets.rate,
                              width: 25.w,
                            ),
                            SvgPicture.asset(
                              AppAssets.rate,
                              width: 25.w,
                            ),
                            SvgPicture.asset(
                              AppAssets.rate,
                              width: 25.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}