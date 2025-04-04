import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/core/shared/constant/app_constants.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/style/app_colors.dart';

import '../../../../../../core/utils/functions.dart';

class TotalsProductsView extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final String productDesc;
  final double sa3Weight;
  final int sumProductQuantity;
  const TotalsProductsView(
      {super.key,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.sa3Weight,
      required this.productDesc,
      required this.sumProductQuantity});

  @override
  State<TotalsProductsView> createState() => _TotalsProductsViewState();
}

class _TotalsProductsViewState extends State<TotalsProductsView> {
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: AppConstants.animation),
      child: SizedBox(
        height: 120.h,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.75,
              height: 100.h,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.cBackGround,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppConstants.radius),
                    bottomLeft: Radius.circular(AppConstants.radius)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.30,
                    child: Text(widget.productName,
                        style: AppTypography.kLight20
                            .copyWith(fontFamily: AppFonts.boldFontFamily),
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.productPrice.toString(),
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
                    width: MediaQuery.sizeOf(context).width * 0.30,
                    child: Text(widget.productDesc,
                        style: AppTypography.kLight14.copyWith(
                            fontFamily: AppFonts.boldFontFamily,
                            color: AppColors.cGray),
                        overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
            ),
            Positioned(
                top: 30.h,
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    height: 35.h,
                    color: AppColors.cWhite,
                  ),
                )),
            Positioned(
                left: 15.w,
                top: 0,
                child: Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    widget.productImage,
                    width: widget.productImage == 'assets/images/package.png'
                        ? 60.w
                        : 120.w,
                  ),
                )),
            Positioned(
                bottom: 3.h,
                left: 15.w,
                child: SizedBox(
                  width: 120.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        formatWeight(widget.sumProductQuantity * widget.sa3Weight).toString(),
                        style: AppTypography.kLight14.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.cNumber),
                      ),
                      Text(
                        formatWeightString(widget.sumProductQuantity *
                                        widget.sa3Weight).toString() ==
                                "ton"
                            ? AppStrings.ton
                            : AppStrings.kilo,
                        style: AppTypography.kLight14
                            .copyWith(fontFamily: AppFonts.boldFontFamily),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
