import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/entities/cart_items.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/cart/cart_product_item_view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:To3maa/core/shared/style/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import 'dart:ui' as ui;

class CartItemView extends StatefulWidget {
  final bool selected;
  final int index;
  final int zakatId;
  final int membersCount;
  final String zakatValue;
  final String total;
  final String remain;
  final String hijriDate;
  final Function deleteCart;
  final Function setSelected;
  const CartItemView({
    super.key,
    required this.selected,
    required this.zakatId,
    required this.index,
    required this.membersCount,
    required this.zakatValue,
    required this.hijriDate,
    required this.total,
    required this.remain,
    required this.deleteCart,
    required this.setSelected,
  });

  @override
  State<CartItemView> createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  bool showDetails = false;
  final ScrollController _scrollController = ScrollController();

  String? hegriText;
  List? hegriDateParts;
  String? dayName;
  String? hijriDate;
  String? lastPart;

  String hijriYear = '';
  String time = '';

  @override
  void initState() {
    hegriText = widget.hijriDate;
    hegriDateParts = hegriText!.split(",").map((e) => e.trim()).toList();

    dayName = hegriDateParts!.isNotEmpty ? hegriDateParts![0] : '';
    hijriDate = hegriDateParts!.length > 1 ? hegriDateParts![1] : '';
    lastPart = hegriDateParts!.length > 2 ? hegriDateParts![2] : '';

    hijriYear = '';
    time = '';

    if (lastPart!.contains('-')) {
      final yearAndTime = lastPart!.split('-').map((e) => e.trim()).toList();
      hijriYear = yearAndTime[0];
      time = yearAndTime.length > 1 ? yearAndTime[1] : '';
    } else {
      hijriYear = lastPart!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        duration: Duration(milliseconds: AppConstants.animation),
        child: BlocConsumer<ZakatCubit, ZakatState>(
          listener: (context, state) async {
            if (state.zakatState ==
                RequestState.getZakatProductsByZakatIdLoading) {
            } else if (state.zakatState ==
                RequestState.getZakatProductsByZakatIdError) {
            } else if (state.zakatState ==
                RequestState.getZakatProductsByZakatIdLoaded) {
              cartProductsItems = state.zakatProductsByZakatIdList;
            }
          },
          builder: (context, state) {
            return Stack(
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
                                    AppStrings.index.tr(),
                                    style: AppTypography.kLight16.copyWith(
                                        fontFamily: AppFonts.boldFontFamily,
                                        color: AppColors.cBlack),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    widget.index.toString(),
                                    style: AppTypography.kLight16.copyWith(
                                      fontWeight: FontWeight.bold,
                                        color: AppColors.cNumber),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "$dayName - $hijriDate , $hijriYear",
                                style: AppTypography.kLight16.copyWith(
                                    fontFamily: AppFonts.boldFontFamily,
                                    color: AppColors.cNumber),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Directionality(
                                textDirection: ui.TextDirection.ltr,
                                child: Text(
                                    "$time",
                                  style: AppTypography.kLight16.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.cNumber),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.zakatValue.toString(),
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
                                    widget.membersCount.toString(),
                                    style: AppTypography.kLight16.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.cNumber),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    AppStrings.members.tr(),
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
                                    AppStrings.remain.tr(),
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
                                ],
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
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await ZakatCubit.get(context).getZakatProductsByZakatId(
                                          GetZakatProductsByZatatIdRequest(
                                              zakatId: widget.zakatId));

                                      widget.setSelected();

                                      setState(() {
                                        showDetails = true;
                                      });
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
                                        Icons.question_mark,
                                        size: 20.w,
                                        color: AppColors.cTitle,
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
                showDetails && widget.selected
                    ? Positioned(
                  bottom: 2.h,
                  child: FadeInUp(
                    duration:
                    Duration(milliseconds: AppConstants.animation),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.65,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 5.h),
                      height: 130.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.w, color: AppColors.cPrimary),
                        borderRadius:
                        BorderRadius.circular(AppConstants.radius),
                        color: AppColors.cWhite,
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showDetails = false;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: 25.w,
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: state
                                .zakatProductsByZakatIdList.isNotEmpty
                                ? Scrollbar(
                                  thumbVisibility: true,
                                  controller: _scrollController,
                                  child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      controller: _scrollController,
                                      itemCount: state
                                          .zakatProductsByZakatIdList
                                          .length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      separatorBuilder:
                                          (BuildContext cartContext,
                                          int index) =>
                                      const SizedBox(height: 0),
                                      itemBuilder:
                                          (BuildContext cartContext,
                                          int index) {
                                        return CartItemProductView(
                                          productName: state
                                              .zakatProductsByZakatIdList[
                                          index]
                                              .productName,
                                          productDesc: state
                                              .zakatProductsByZakatIdList[
                                          index]
                                              .productDesc,
                                          productQuantity: state
                                              .zakatProductsByZakatIdList[
                                          index]
                                              .productQuantity
                                              .toString(),
                                        );
                                      }),
                                )
                                : Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                    : Container(),
              ],
            );
          },
        ));
  }
}