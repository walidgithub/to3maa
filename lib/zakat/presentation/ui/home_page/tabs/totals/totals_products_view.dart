import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/core/shared/constant/app_constants.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/constant/language_manager.dart';
import '../../../../../../core/shared/style/app_colors.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/functions.dart';
import '../../../../ui_components/loading_dialog.dart';
import '../../cubit/zakat_cubit.dart';
import '../../cubit/zakat_states.dart';

class TotalsProductsView extends StatefulWidget {
  final int productId;
  final String productImage;
  final String productName;
  final String productPrice;
  final String productDesc;
  final double sa3Weight;
  final int sumProductQuantity;
  final int sumPurchasesQuantity;
  const TotalsProductsView(
      {super.key,
      required this.productId,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.sa3Weight,
      required this.productDesc,
      required this.sumPurchasesQuantity,
      required this.sumProductQuantity});

  @override
  State<TotalsProductsView> createState() => _TotalsProductsViewState();
}

class _TotalsProductsViewState extends State<TotalsProductsView> {
  int membersCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ZakatCubit>()..getMembersCountByProduct(widget.productName),
      child: BlocConsumer<ZakatCubit, ZakatState>(
      listener: (context, state) {
        if (state.zakatState ==  RequestState.getMembersCountLoading) {
          showLoading();
        } else if (state.zakatState ==  RequestState.getMembersCountLoaded) {
          membersCount = state.membersCount;
          hideLoading();
        } else if (state.zakatState ==  RequestState.getMembersCountError) {
          hideLoading();
        }
      },
          builder: (context, state) {
        return FadeInUp(
          duration: Duration(milliseconds: AppConstants.animation),
          child: SizedBox(
            height: widget.productDesc != "" ? 230.h : 210.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  height: widget.productDesc != "" ? 210.h : 190.h,
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.cBackGround,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppConstants.radius),
                        bottomLeft: Radius.circular(AppConstants.radius)),
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
                    right: isRtl() ? null : 15.w,
                    left: isRtl() ? 15.w : null,
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
                    top: 30.h,
                    right: isRtl() ? 10.w : null,
                    left: isRtl() ? null : 10.w,
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
                              AppStrings.allNumberOfIndividuals.tr(),
                              style: AppTypography.kLight16.copyWith(
                                  fontFamily: AppFonts.boldFontFamily,
                                  color: AppColors.cBlack),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              membersCount.toString(),
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
                              widget.productPrice.toString(),
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
                              AppStrings.zakat.tr(),
                              style: AppTypography.kLight16.copyWith(
                                  fontFamily: AppFonts.boldFontFamily,
                                  color: AppColors.cBlack),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              formatWeight(widget.sumProductQuantity * widget.sa3Weight).toString(),
                              style: AppTypography.kLight14.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.cNumber),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              formatWeightString(widget.sumProductQuantity *
                                  widget.sa3Weight).toString() ==
                                  "ton"
                                  ? AppStrings.ton.tr()
                                  : AppStrings.kilo.tr(),
                              style: AppTypography.kLight14
                                  .copyWith(fontFamily: AppFonts.boldFontFamily),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppStrings.buyFromRemain.tr(),
                              style: AppTypography.kLight16.copyWith(
                                  fontFamily: AppFonts.boldFontFamily,
                                  color: AppColors.cBlack),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              formatWeight(widget.sumPurchasesQuantity).toString(),
                              style: AppTypography.kLight14.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.cNumber),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              formatWeightString(widget.sumPurchasesQuantity).toString() ==
                                  "ton"
                                  ? AppStrings.ton.tr()
                                  : AppStrings.kilo.tr(),
                              style: AppTypography.kLight14
                                  .copyWith(fontFamily: AppFonts.boldFontFamily),
                            ),
                          ],
                        ),
                        widget.productDesc != "" ? SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.30,
                          child: Text(widget.productDesc,
                              style: AppTypography.kLight14.copyWith(
                                  fontFamily: AppFonts.boldFontFamily,
                                  color: AppColors.cGray),
                              overflow: TextOverflow.ellipsis),
                        ) : Container()
                      ],
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
