import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/purchases/purchase_total_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/purchases/summed_product.dart';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../../core/shared/constant/app_typography.dart';
import '../../../../../../../core/shared/style/app_colors.dart';
import '../../../../../../../core/utils/enums.dart';
import '../../../../../../domain/responses/purchases_response.dart';
import '../../../../../ui_components/loading_dialog.dart';
import '../../../cubit/zakat_cubit.dart';
import '../../../cubit/zakat_states.dart';

class PurchasesTotalView extends StatefulWidget {
  const PurchasesTotalView({super.key});

  @override
  State<PurchasesTotalView> createState() => _PurchasesTotalViewState();
}

class _PurchasesTotalViewState extends State<PurchasesTotalView> {

  List<PurchasesResponse> purchasesList = [];
  List<SummedProduct> purchasesTotalList = [];

  @override
  void initState() {
    getAllPurchases();
    getTotalOfPurchases();
    super.initState();
  }

  double purchasesTotal = 0.0;

  Future<void> getTotalOfPurchases() async {
    await ZakatCubit.get(context).getTotalOfPurchases();
  }

  getAllPurchases() async {
    await ZakatCubit.get(context).getAllPurchases();
  }

  List<SummedProduct> summarizePurchases(List<PurchasesResponse> purchasesList) {
    final Map<String, SummedProduct> grouped = {};

    for (var item in purchasesList) {
      final name = item.productName?.trim() ?? 'Unknown';
      final quantity = double.tryParse(item.productQuantity?.toString() ?? '0') ?? 0.0;
      final unitPrice = double.tryParse(item.productPrice?.toString() ?? '0') ?? 0.0;
      final totalPrice = unitPrice * quantity;

      if (grouped.containsKey(name)) {
        final existing = grouped[name]!;
        grouped[name] = SummedProduct(
          productName: name,
          totalProductQuantity: existing.totalProductQuantity + quantity,
          totalProductPrice: existing.totalProductPrice + totalPrice,
        );
      } else {
        grouped[name] = SummedProduct(
          productName: name,
          totalProductQuantity: quantity,
          totalProductPrice: totalPrice,
        );
      }
    }

    return grouped.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child:
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FadeInLeft(
                duration: Duration(milliseconds: AppConstants.animation),
                child: Text(
                  AppStrings.totalPurchases.tr(),
                  style: AppTypography.kLight20
                      .copyWith(fontFamily: AppFonts.boldFontFamily),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 30.w,
                  height: 30.w,
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
                      Icons.arrow_forward_ios,
                      size: 20.w,
                      color: AppColors.cButton,
                    ),
                  ),
                ),
              )
            ],
          ),
          BlocConsumer<ZakatCubit, ZakatState>(
              listener: (context, state) async {
                if (state.zakatState == RequestState.purchasesLoading) {
                  showLoading();
                } else if (state.zakatState == RequestState.purchasesError) {
                  hideLoading();
                } else if (state.zakatState == RequestState.purchasesLoaded) {
                  purchasesList = state.purchasesList;
                  purchasesTotalList = summarizePurchases(purchasesList);
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
            return SizedBox(
              height: MediaQuery.sizeOf(context).height -50.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                      child: purchasesTotalList.isNotEmpty
                          ? SingleChildScrollView(
                            child: ListView.separated(
                            itemCount: purchasesTotalList.length,
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
                              return PurchaseTotalView(
                                productName: purchasesTotalList[index].productName,
                                productTotalQuantity: purchasesTotalList[index].totalProductQuantity,
                                productTotalPrice: purchasesTotalList[index].totalProductPrice,
                              );
                            }),
                          )
                          : Center(
                        child: Text(
                          AppStrings.noPurchases.tr(),
                          style:
                          const TextStyle(fontFamily: AppFonts.qabasFontFamily),
                        ),
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 50.h,
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    padding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.radius),
                      color: AppColors.cButton,
                    ),
                    child: Column(
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
                                purchasesTotal.toString(),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.07.h,
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
