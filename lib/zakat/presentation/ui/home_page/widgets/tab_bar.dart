import 'package:flutter/material.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;

class TabBarWidget extends StatelessWidget {
  final bool activeTab;
  final String title;
  final String icon;
  final int index;
  final int badgeVal;
  const TabBarWidget({
    super.key,
    required this.activeTab,
    required this.title,
    required this.icon,
    required this.index,
    required this.badgeVal,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 1.h,
          ),
          RotatedBox(
            quarterTurns: 1,
            child: index == 1
                ? badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    badgeContent: Text(
                      badgeVal.toString(),
                      style: AppTypography.kBold14.copyWith(
                          color: AppColors.cWhite,
                          fontFamily: AppFonts.boldFontFamily),
                    ),
                    showBadge: true,
                    ignorePointer: false,
                    child: SvgPicture.asset(
                      icon,
                      width: 25.w,
                    ),
                  )
                : SvgPicture.asset(
                    icon,
                    width: 25.w,
                  ),
          ),
          Text(
            title,
            style: AppTypography.kBold16.copyWith(
                fontFamily: AppFonts.qabasFontFamily,
                color: activeTab ? AppColors.cBlack : AppColors.cGray),
          ),
          Container(
            width: 30.w,
            height: 5.h,
            decoration: BoxDecoration(
                color: activeTab ? AppColors.cPrimary : AppColors.cBackGround),
          )
        ],
      ),
    );
  }
}
