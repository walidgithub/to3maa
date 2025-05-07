import 'dart:async';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/requests/delete_members_count_request.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/cart/check_delete_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To3maa/zakat/domain/entities/cart_items.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/cart/cart_item_view.dart';
import 'package:To3maa/zakat/presentation/ui_components/loading_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:ui' as ui;
import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/style/app_colors.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    getAllZakat();
    getTotalOfPurchases();
    getTotalOfSundries();
    super.initState();
  }

  List<Cart> cart = [];

  int membersCountText = 0;
  double purchasesTotal = 0.0;
  double sundriesTotal = 0.0;

  void getTotalMembersCount(List<Cart> carts) {
    setState(() {
      membersCountText =
          carts.fold(0, (sum, cart) => sum + (cart.membersCount ?? 0));
    });
  }

  Future<void> getAllZakat() async {
    await ZakatCubit.get(context).getAllZakat();
  }

  Future<void> deleteMembersCount(int productId) async {
    DeleteMembersCountRequest deleteMembersCountRequest = DeleteMembersCountRequest(id: productId);
    await ZakatCubit.get(context).deleteMembersCount(deleteMembersCountRequest);
  }

  Future<void> deleteZakat(int productId) async {
    DeleteZakatRequest deleteZakatRequest =
    (DeleteZakatRequest(id: productId));
    await ZakatCubit.get(
        context)
        .deleteZakat(
        deleteZakatRequest);
  }

  Future<void> deleteZakatProducts(int productId) async {
    DeleteZakatProductsRequest
    deleteZakatProductsRequest =
    (DeleteZakatProductsRequest(id: productId));

    await ZakatCubit.get(
        context)
        .deleteZakatProducts(
        deleteZakatProductsRequest);
  }

  Future<void> deleteAll() async {
    await ZakatCubit.get(context).deleteAllZakat();
  }

  Future<void> getTotalOfPurchases() async {
    await ZakatCubit.get(context).getTotalOfPurchases();
  }

  Future<void> getTotalOfSundries() async {
    await ZakatCubit.get(context).getTotalOfSundries();
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
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cWhite,
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          title: FadeInLeft(
            duration: Duration(milliseconds: AppConstants.animation),
            child: Text(
              AppStrings.cart.tr(),
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
            cart.clear();
            for (var x in state.zakatList) {
              cart.add(Cart(
                  id: x.id,
                  membersCount: x.membersCount,
                  remainValue: x.remainValue,
                  hijriDate: x.hegriDate,
                  selected: false,
                  zakatValue: x.zakatValue));
            }
            getTotalMembersCount(cart);
            hideLoading();
          } else if (state.zakatState == RequestState.deleteLoading) {
            showLoading();
          } else if (state.zakatState == RequestState.deleteError) {
            hideLoading();
          } else if (state.zakatState == RequestState.deleteDone) {
            hideLoading();
          } else if (state.zakatState == RequestState.totalSundriesLoading) {
            showLoading();
          } else if (state.zakatState == RequestState.totalSundriesLoaded) {
            sundriesTotal = state.sundriesTotal;
            hideLoading();
          } else if (state.zakatState == RequestState.totalSundriesError) {
            hideLoading();
          } else if (state.zakatState == RequestState.totalPurchasesLoading) {
            showLoading();
          } else if (state.zakatState == RequestState.totalPurchasesLoaded) {
            purchasesTotal = state.purchasesTotal;
            hideLoading();
          } else if (state.zakatState == RequestState.totalPurchasesError) {
            hideLoading();
          }
        }, builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                  child: cart.isNotEmpty
                      ? SingleChildScrollView(
                          child: ListView.separated(
                              itemCount: cart.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder:
                                  (BuildContext cartContext, int index) =>
                                      SizedBox(
                                        height: 20.h,
                                      ),
                              itemBuilder:
                                  (BuildContext cartContext, int index) {
                                return CartItemView(
                                  index: cart.length - index,
                                  selected: cart[index].selected!,
                                  hijriDate: cart[index].hijriDate!,
                                  zakatId: cart[index].id!,
                                  membersCount: cart[index].membersCount!,
                                  zakatValue: cart[index].zakatValue!,
                                  total: cart[index].zakatValue!,
                                  remain: cart[index].remainValue!,
                                  setSelected: () async {
                                    setState(() {
                                      for (var n in cart) {
                                        n.selected = false;
                                      }
                                      cart[index].selected = true;
                                    });
                                  },
                                  deleteCart: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Directionality(
                                            textDirection: ui.TextDirection.rtl,
                                            child: AlertDialog(
                                              title: Text(AppStrings.warning.tr(),
                                                  style: AppTypography.kBold20),
                                              content: Text(
                                                  AppStrings.checkToDelete.tr()),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      await deleteZakat(cart[index].id!);
                                                      await deleteZakatProducts(cart[index].id!);
                                                      await deleteMembersCount(cart[index].id!);

                                                      cart.removeWhere(
                                                        (element) =>
                                                            element.id ==
                                                                cart[index].id!,
                                                      );

                                                      final snackBar = SnackBar(
                                                        duration: Duration(
                                                            milliseconds:
                                                                AppConstants
                                                                    .durationOfSnackBar),
                                                        content: Text(
                                                            AppStrings
                                                                .successDelete.tr()),
                                                      );
                                                      // ignore: use_build_context_synchronously
                                                      ScaffoldMessenger.of(
                                                              cartContext)
                                                          .showSnackBar(
                                                              snackBar);

                                                      await getAllZakat();

                                                      getTotalMembersCount(
                                                          cart);
                                                      getTotalOfPurchases();
                                                      getTotalOfSundries();

                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text(AppStrings.yes.tr(),
                                                        style: AppTypography
                                                            .kLight16)),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text(AppStrings.no.tr(),
                                                        style: AppTypography
                                                            .kLight16)),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                );
                              }),
                        )
                      : Center(
                          child: Text(
                            AppStrings.noCarts.tr(),
                            style:
                                const TextStyle(fontFamily: AppFonts.qabasFontFamily),
                          ),
                        )),
              SizedBox(
                height: 5.h,
              ),
              Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.4.w,
                  motion: const ScrollMotion(),
                  children: [
                    SizedBox(width: 10.w),
                    Builder(
                      builder: (innerContext) => GestureDetector(
                        onTap: () async {
                          Slidable.of(innerContext)?.close();

                          if (cartItems.isNotEmpty) {
                            CheckDeleteDialog.show(innerContext, () async {
                              await deleteAll();
                              await getAllZakat();
                              getTotalMembersCount(cart);
                              cart.clear();
                              setState(() {});
                            });
                          }
                        },
                        child: Container(
                          width: 50.w,
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
                            child: Icon(
                              Icons.delete_outline,
                              size: 30.w,
                              color: AppColors.cButton,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                child: Container(
                  height: 110.h,
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.radius),
                    color: AppColors.cButton,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppStrings.total.tr(),
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
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.cBlack),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    AppStrings.defaultCurrency.tr(),
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
                                AppStrings.remain.tr(),
                                style: AppTypography.kBold18.copyWith(
                                  color: AppColors.cWhite,
                                  fontFamily: AppFonts.qabasFontFamily,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    (getRemain() - sundriesTotal - purchasesTotal).toString(),
                                    style: AppTypography.kLight16.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.cBlack),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    AppStrings.defaultCurrency.tr(),
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
                                AppStrings.allNumberOfIndividuals.tr(),
                                style: AppTypography.kBold18.copyWith(
                                  color: AppColors.cWhite,
                                  fontFamily: AppFonts.qabasFontFamily,
                                ),
                              ),
                              Text(
                                membersCountText.toString(),
                                style: AppTypography.kLight16.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.cBlack),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.cWhite,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.07.h,
              ),
            ],
          );
        }),
      ),
    );
  }
}
