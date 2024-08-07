import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemView extends StatefulWidget {
  final int membersCount;
  final String zakatValue;
  final String total;
  final String remain;
  final Function deleteCart;
  const CartItemView({
    super.key,
    required this.membersCount,
    required this.zakatValue,
    required this.total,
    required this.remain,
    required this.deleteCart,
  });

  @override
  State<CartItemView> createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: AppConstants.animation),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 0.75,
            height: 80.h,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.zakatValue.toString(),
                              style: AppTypography.kLight16.copyWith(
                                  fontFamily: AppFonts.boldFontFamily,
                                  color: AppColors.cNumber),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'ج.م',
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
                              widget.membersCount.toString(),
                              style: AppTypography.kLight16.copyWith(
                                  fontFamily: AppFonts.boldFontFamily,
                                  color: AppColors.cNumber),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'أفراد',
                              style: AppTypography.kLight16.copyWith(
                                  fontFamily: AppFonts.boldFontFamily,
                                  color: AppColors.cBlack),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.remain,
                              style: AppTypography.kLight16.copyWith(
                                  fontFamily: AppFonts.boldFontFamily,
                                  color: AppColors.cBlack),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.remain.toString(),
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cNumber),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'ج.م',
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cBlack),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
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
                                      width: 2.w, color: AppColors.cPrimary),
                                  borderRadius: BorderRadius.circular(4.w),
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
      ),
    );
  }
}
