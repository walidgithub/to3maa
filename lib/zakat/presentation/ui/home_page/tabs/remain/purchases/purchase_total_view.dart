import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:To3maa/core/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../../core/shared/constant/app_strings.dart';

class PurchaseTotalView extends StatefulWidget {
  final String productName;
  final double productTotalQuantity;
  final double productTotalPrice;
  const PurchaseTotalView({
    super.key,
    required this.productName,
    required this.productTotalQuantity,
    required this.productTotalPrice
  });

  @override
  State<PurchaseTotalView> createState() => _PurchaseTotalViewState();
}

class _PurchaseTotalViewState extends State<PurchaseTotalView> {
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
                                "${AppStrings.productName.tr()}:",
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                widget.productName,
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
                                "${AppStrings.productPriceWKilo.tr()}:",
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                (widget.productTotalPrice / widget.productTotalQuantity).toStringAsFixed(2),
                                style: AppTypography.kLight16.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.cNumber),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                AppStrings.defaultCurrency.tr(),
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "${AppStrings.totalOfQuantityByKilo.tr()}:",
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                widget.productTotalQuantity.toString(),
                                style: AppTypography.kLight16.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.cNumber),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                AppStrings.kilo.tr(),
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Text(
                                AppStrings.total.tr(),
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                widget.productTotalPrice.toString(),
                                style: AppTypography.kLight16.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.cNumber),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                AppStrings.defaultCurrency.tr(),
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