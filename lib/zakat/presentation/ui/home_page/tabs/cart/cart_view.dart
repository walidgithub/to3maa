import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/entities/cart_items.dart';
import 'package:To3maa/zakat/domain/requsts/delete_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requsts/delete_zakat_request.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/cart/cart_item_view.dart';
import 'package:To3maa/zakat/presentation/ui_components/loading_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    getAllZakat();
    super.initState();
  }

  Future<void> getAllZakat() async {
    await ZakatCubit.get(context).getAllZakat();
  }

  Future<void> deleteAll() async {
    await ZakatCubit.get(context).deleteAllZakat();
    await ZakatCubit.get(context).deleteAllZakatProducts();
  }

  double getTotal() {
    double total = 0.0;
    for (var x in cartItems) {
      total = total + double.parse(x.zakatValue);
    }
    return total;
  }

  double getRemain() {
    double remain = 0.0;
    for (var x in cartItems) {
      remain = remain + double.parse(x.remainValue);
    }
    return remain;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cWhite,
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          title: FadeInLeft(
            duration: Duration(milliseconds: AppConstants.animation),
            child: Text(
              AppStrings.cart,
              style: AppTypography.kLight20
                  .copyWith(fontFamily: AppFonts.boldFontFamily),
            ),
          ),
        ),
        backgroundColor: AppColors.cWhite,
        body: BlocConsumer<ZakatCubit, ZakatState>(
            listener: (context, state) async {
          if (state.zakatState == RequestState.zakatLoading) {
            showLoading();
          } else if (state.zakatState == RequestState.zakatError) {
            hideLoading();
          } else if (state.zakatState == RequestState.zakatLoaded) {
            cartItems = state.zakatList;
            hideLoading();
          } else if (state.zakatState == RequestState.deleteLoading) {
            showLoading();
          } else if (state.zakatState == RequestState.deleteError) {
            hideLoading();
          } else if (state.zakatState == RequestState.deleteDone) {
            hideLoading();
          }
        }, builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                  child: cartItems.isNotEmpty
                      ? SingleChildScrollView(
                          child: ListView.separated(
                              itemCount: cartItems.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                        height: 20.h,
                                      ),
                              itemBuilder: (BuildContext context, int index) {
                                DeleteZakatRequest deleteZakatRequest =
                                    (DeleteZakatRequest(
                                        id: cartItems[index].id));
                                DeleteZakatProductsRequest
                                    deleteZakatProductsRequest =
                                    (DeleteZakatProductsRequest(
                                        id: cartItems[index].id));
                                return CartItemView(
                                  membersCount: cartItems[index].membersCount,
                                  zakatValue: cartItems[index].zakatValue,
                                  total: cartItems[index].zakatValue,
                                  remain: cartItems[index].remainValue,
                                  deleteCart: () async {
                                    await ZakatCubit.get(context)
                                        .deleteZakat(deleteZakatRequest);

                                    // ignore: use_build_context_synchronously
                                    await ZakatCubit.get(context)
                                        .deleteZakatProducts(
                                            deleteZakatProductsRequest);

                                    final snackBar = SnackBar(
                                      duration: Duration(
                                          milliseconds:
                                              AppConstants.durationOfSnackBar),
                                      content:
                                          const Text(AppStrings.successDelete),
                                    );
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    await getAllZakat();
                                    setState(() {});
                                  },
                                );
                              }),
                        )
                      : const Center(
                          child: Text(
                            AppStrings.noCarts,
                            style:
                                TextStyle(fontFamily: AppFonts.qabasFontFamily),
                          ),
                        )),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 150.h,
                width: MediaQuery.sizeOf(context).width * 0.75,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius),
                  color: AppColors.cButton,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.total,
                              style: AppTypography.kBold18.copyWith(
                                color: AppColors.cWhite,
                                fontFamily: AppFonts.qabasFontFamily,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  getTotal().toString(),
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cBlack),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'ج.م',
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cWhite),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              AppStrings.remain,
                              style: AppTypography.kBold18.copyWith(
                                color: AppColors.cWhite,
                                fontFamily: AppFonts.qabasFontFamily,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  getRemain().toString(),
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cBlack),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'ج.م',
                                  style: AppTypography.kLight16.copyWith(
                                      fontFamily: AppFonts.boldFontFamily,
                                      color: AppColors.cWhite),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        cartItems.isNotEmpty
                            ? await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      title: Text(AppStrings.warning,style: AppTypography.kBold18),
                                      content:
                                          const Text(AppStrings.deleteAllData),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await deleteAll();
                                              await getAllZakat();
                                              final snackBar = SnackBar(
                                                duration: Duration(
                                                    milliseconds: AppConstants
                                                        .durationOfSnackBar),
                                                content: Text(
                                                    AppStrings.successDelete,style: AppTypography.kBold16),
                                              );
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(AppStrings.yes,style: AppTypography.kLight14)),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(AppStrings.no,style: AppTypography.kLight14)),
                                      ],
                                    ),
                                  );
                                })
                            : null;
                      },
                      child: Container(
                          width: 80.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.w, color: AppColors.cPrimary),
                            borderRadius:
                                BorderRadius.circular(AppConstants.radius),
                            color: AppColors.cWhite,
                            shape: BoxShape.rectangle,
                          ),
                          child: Center(
                            child: Text(
                              AppStrings.deleteAll,
                              style: AppTypography.kLight14.copyWith(
                                fontFamily: AppFonts.qabasFontFamily,
                                color: AppColors.cButton,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          );
        }),
      ),
    );
  }
}
