import 'package:flutter/material.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_constants.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_typography.dart';
import 'package:flutter_laravel/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class AddProductView extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final String productDesc;
  const AddProductView(
      {super.key,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productDesc});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  int itemQuantity = 0;
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
                  Text(
                    widget.productName,
                    style: AppTypography.kLight20
                        .copyWith(fontFamily: AppFonts.boldFontFamily),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.productPrice,
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
                  Text(
                    widget.productDesc,
                    style: AppTypography.kLight14.copyWith(
                        fontFamily: AppFonts.boldFontFamily,
                        color: AppColors.cGray),
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
                bottom: 5.h,
                left: 15.w,
                child: SizedBox(
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            itemQuantity++;
                          });
                        },
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2.w, color: AppColors.cWhite),
                            borderRadius: BorderRadius.circular(4.w),
                            color: AppColors.cPrimary,
                            shape: BoxShape.rectangle,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 16.w,
                          ),
                        ),
                      ),
                      Text(
                        itemQuantity.toString(),
                        style: AppTypography.kLight14
                            .copyWith(fontFamily: AppFonts.boldFontFamily),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (itemQuantity != 0) {
                              itemQuantity--;
                            }
                          });
                        },
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2.w, color: AppColors.cWhite),
                            borderRadius: BorderRadius.circular(4.w),
                            color: AppColors.cPrimary,
                            shape: BoxShape.rectangle,
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 16.w,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
