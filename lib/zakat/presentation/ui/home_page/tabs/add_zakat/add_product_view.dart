import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/style/app_colors.dart';

class AddProductView extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final String productDesc;
  final int productQuantity;
  final int membersCount;
  final Function increaseQunatity;
  final Function decreaseQunatity;
  final double allValue;
  final List<ProductsResponse> productsList;
  const AddProductView({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.productQuantity,
    required this.membersCount,
    required this.increaseQunatity,
    required this.decreaseQunatity,
    required this.allValue,
    required this.productsList,
  });

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  double usedAmount(var products) {
    return products.fold(0, (sum, item) => sum + (double.parse(item.productQuantity.toString()) * double.parse(item.productPrice.toString())));
  }

  int? _itemQuantity;

  int getTotalProductQuantity(List<ProductsResponse> products) {
    return products.fold(0, (sum, product) => sum + (product.productQuantity ?? 0));
  }

  @override
  void initState() {
    _itemQuantity = 0;
    super.initState();
  }
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
                    child: Text(
                      widget.productName,
                      style: AppTypography.kLight20
                          .copyWith(fontFamily: AppFonts.boldFontFamily),
                      overflow: TextOverflow.ellipsis,
                    ),
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
                    child: Text(
                      widget.productDesc,
                      style: AppTypography.kLight14.copyWith(
                          fontFamily: AppFonts.boldFontFamily,
                          color: AppColors.cGray),
                      overflow: TextOverflow.ellipsis,
                    ),
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
                          double remain =
                              widget.allValue - usedAmount(widget.productsList) - double.parse(widget.productPrice);
                          if (remain.isNegative) {
                            return;
                          }

                          if (widget.membersCount < getTotalProductQuantity(widget.productsList) + 1) {
                            return;
                          }

                          setState(() {
                            _itemQuantity = _itemQuantity! + 1;
                          });

                          widget.increaseQunatity(_itemQuantity);
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
                        widget.productQuantity.toString(),
                        style: AppTypography.kLight14
                            .copyWith(fontWeight: FontWeight.bold,),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_itemQuantity != 0) {
                            setState(() {
                              _itemQuantity = _itemQuantity! - 1;
                            });
                          }
                          widget.decreaseQunatity(_itemQuantity);
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
