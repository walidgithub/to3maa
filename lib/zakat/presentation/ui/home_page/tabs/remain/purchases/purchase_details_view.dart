import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:To3maa/core/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../../core/shared/constant/language_manager.dart';

class PurchaseDetailsView extends StatefulWidget {
  final int index;
  final int id;
  final String productName;
  final String productPrice;
  final int productQuantity;
  final Function deleteCart;
  const PurchaseDetailsView({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.index,
    required this.deleteCart,
    required this.id,
  });

  @override
  State<PurchaseDetailsView> createState() => _PurchaseDetailsViewState();
}

class _PurchaseDetailsViewState extends State<PurchaseDetailsView> {
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
                                widget.productPrice,
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
                                "${AppStrings.quantityByKilo.tr()}:",
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: isRtl() ? AppFonts.boldFontFamily : null,
                                    color: AppColors.cBlack),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                widget.productQuantity.toString(),
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
                                "${widget.productQuantity * int.parse(widget.productPrice)}",
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

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}