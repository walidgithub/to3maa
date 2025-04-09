import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:To3maa/core/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../../core/shared/constant/app_strings.dart';

class SundryTotalView extends StatefulWidget {
  final String sundryName;
  final double sundryTotal;
  const SundryTotalView({
    super.key,
    required this.sundryName,
    required this.sundryTotal,
  });

  @override
  State<SundryTotalView> createState() => _SundryTotalViewState();
}

class _SundryTotalViewState extends State<SundryTotalView> {
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        duration: Duration(milliseconds: AppConstants.animation),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.cBackGround,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppConstants.radius),
                    bottomLeft: Radius.circular(AppConstants.radius)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${AppStrings.sundryName}:",
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                widget.sundryName,
                                style: AppTypography.kLight16.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.cNumber),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Text(
                                AppStrings.total,
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                widget.sundryTotal.toString(),
                                style: AppTypography.kLight16.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.cNumber),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                AppStrings.currency,
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}