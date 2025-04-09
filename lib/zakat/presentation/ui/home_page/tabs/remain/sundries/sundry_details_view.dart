import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:To3maa/core/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../../core/shared/constant/app_strings.dart';

class SundryDetailsView extends StatefulWidget {
  final int index;
  final int id;
  final String sundryName;
  final String sundryPrice;
  final Function deleteCart;
  const SundryDetailsView({
    super.key,
    required this.sundryName,
    required this.sundryPrice,
    required this.index,
    required this.deleteCart,
    required this.id,
  });

  @override
  State<SundryDetailsView> createState() => _SundryDetailsViewState();
}

class _SundryDetailsViewState extends State<SundryDetailsView> {
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
                                "${AppStrings.sundryPrice}:",
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cBlack),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                widget.sundryPrice,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.deleteCart();
                                },
                                child: Container(
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2.w,
                                        color: AppColors.cPrimary),
                                    borderRadius:
                                    BorderRadius.circular(4.w),
                                    color: AppColors.cWhite,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Icon(
                                    Icons.delete_outline,
                                    size: 20.w,
                                    color: AppColors.cButton,
                                  ),
                                ),
                              ),
                            ],
                          )
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