import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_purchase_request.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/purchase_view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/constant/app_typography.dart';
import '../../../../../../core/shared/style/app_colors.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../domain/responses/purchases_response.dart';
import '../../../../../domain/responses/purchases_response.dart';
import '../../../../ui_components/loading_dialog.dart';
import '../../cubit/zakat_cubit.dart';
import '../../cubit/zakat_states.dart';

class PurchasesView extends StatefulWidget {
  const PurchasesView({super.key});

  @override
  State<PurchasesView> createState() => _PurchasesViewState();
}

class _PurchasesViewState extends State<PurchasesView> {

  List<PurchasesResponse> purchasesList = [];

  @override
  void initState() {
    getAllPurchases();
    super.initState();
  }

  getAllPurchases() async {
    await ZakatCubit.get(context).getAllPurchases();
  }

  double getTotalSundryPrice(List<PurchasesResponse> items) {
    return items.fold(0.0, (total, item) {
      final price = double.tryParse(item.productPrice ?? '');
      return total + (price ?? 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cWhite,
      child:
      Column(
        children: [
          FadeInLeft(
            duration: Duration(milliseconds: AppConstants.animation),
            child: Text(
              AppStrings.buyProducts,
              style: AppTypography.kLight20
                  .copyWith(fontFamily: AppFonts.boldFontFamily),
            ),
          ),
          BlocConsumer<ZakatCubit, ZakatState>(
              listener: (context, state) async {
                if (state.zakatState == RequestState.purchasesLoading) {
                  showLoading();
                } else if (state.zakatState == RequestState.purchasesError) {
                  hideLoading();
                } else if (state.zakatState == RequestState.purchasesLoaded) {
                  purchasesList = state.purchasesList;
                  hideLoading();
                } else if (state.zakatState == RequestState.deleteLoading) {
                  showLoading();
                } else if (state.zakatState == RequestState.deleteError) {
                  hideLoading();
                } else if (state.zakatState == RequestState.deleteDone) {
                  getAllPurchases();
                  hideLoading();
                  Navigator.of(context)
                      .pop(false);
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
                      child: purchasesList.isNotEmpty
                          ? ListView.separated(
                          itemCount: purchasesList.length,
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
                            return PurchaseView(
                              index: purchasesList.length - index,
                              productName: purchasesList[index].productName!,
                              productPrice: purchasesList[index].productPrice!,
                              productQuantity: purchasesList[index].productQuantity!,
                              id: purchasesList[index].id,
                              deleteCart: () async {
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text(AppStrings.warning,
                                              style: AppTypography.kBold20),
                                          content: const Text(
                                              AppStrings.checkToDelete),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  DeletePurchaseRequest deletePurchaseRequest = DeletePurchaseRequest(id: purchasesList[index].id);
                                                  await ZakatCubit.get(
                                                      cartContext)
                                                      .deletePurchase(
                                                      deletePurchaseRequest);
                                                },
                                                child: Text(AppStrings.yes,
                                                    style: AppTypography
                                                        .kLight16)),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text(AppStrings.no,
                                                    style: AppTypography
                                                        .kLight16)),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            );
                          })
                          : const Center(
                        child: Text(
                          AppStrings.noPurchases,
                          style:
                          TextStyle(fontFamily: AppFonts.qabasFontFamily),
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
                              AppStrings.total,
                              style: AppTypography.kBold18.copyWith(
                                color: AppColors.cWhite,
                                fontFamily: AppFonts.qabasFontFamily,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  getTotalSundryPrice(purchasesList).toString(),
                                  style: AppTypography.kLight16.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.cBlack),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  AppStrings.currency,
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
