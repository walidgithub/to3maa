import 'package:To3maa/zakat/presentation/shared/constant/app_assets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/totals/totals_products_view.dart';
import 'package:To3maa/zakat/presentation/ui_components/loading_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../domain/entities/cart_items.dart';
import 'export_class.dart';

class TotalsView extends StatefulWidget {
  const TotalsView({super.key});

  @override
  State<TotalsView> createState() => _TotalsViewState();
}

class _TotalsViewState extends State<TotalsView> {
  List<ZakatProductsByKilosResponse> zakatByKilos = [];

  @override
  void initState() {
    getZakatByKilos();
    for (var x in cartItems) {
      cart.add(Cart(
          id: x.id,
          membersCount: x.membersCount,
          remainValue: x.remainValue,
          hijriDate: x.hegriDate,
          selected: false,
          zakatValue: x.zakatValue));
    }
    super.initState();
  }

  List<Cart> cart = [];

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

  int getTotalMembersCount(List<Cart> carts) {
    return carts.fold(0, (sum, cart) => sum + (cart.membersCount ?? 0));
  }

  Future<void> getZakatByKilos() async {
    await ZakatCubit.get(context).getZakatProductsByKilos();
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
              child: Row(
                children: [
                  Text(
                    AppStrings.totals,
                    style: AppTypography.kLight20
                        .copyWith(fontFamily: AppFonts.boldFontFamily),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await Permission.manageExternalStorage.request().isGranted) {
                        await exportCartsAndProductsDesign(
                          carts: cart,
                          products: zakatByKilos,
                        );
                      } else {
                        print("Manage External Storage permission denied");
                      }
                    },
                    child: SvgPicture.asset(
                      AppAssets.export,
                      width: 25.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: AppColors.cWhite,
          body: BlocConsumer<ZakatCubit, ZakatState>(
              listener: (context, state) async {
            if (state.zakatState ==
                RequestState.getZakatProductsByKilosLoading) {
              showLoading();
            } else if (state.zakatState ==
                RequestState.getZakatProductsByKilosError) {
              hideLoading();
            } else if (state.zakatState ==
                RequestState.getZakatProductsByKilosLoaded) {
              zakatByKilos = state.zakatProductsByKiloList;
              hideLoading();
            }
          }, builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                        child: zakatByKilos.isNotEmpty
                            ? SingleChildScrollView(
                          child: ListView.separated(
                                              itemCount: zakatByKilos.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics: const NeverScrollableScrollPhysics(),
                                              separatorBuilder:
                                                  (BuildContext context, int index) =>
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),
                                              itemBuilder: (BuildContext context, int index) {
                                                return TotalsProductsView(
                                                    productName:
                                                        zakatByKilos[index].productName,
                                                    productImage:
                                                        zakatByKilos[index].productImage,
                                                    productPrice:
                                                        zakatByKilos[index].productPrice,
                                                    sa3Weight: zakatByKilos[index].sa3Weight,
                                                    productDesc:
                                                        zakatByKilos[index].productDesc,
                                                    sumProductQuantity: zakatByKilos[index]
                                                        .sumProductQuantity!);
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
                      height: 110.h,
                      width: MediaQuery.sizeOf(context).width * 0.75,
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.radius),
                        color: AppColors.cButton,
                      ),
                      child: Row(
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
                              Row(
                                children: [
                                  Text(
                                    AppStrings.allMembersCount,
                                    style: AppTypography.kBold18.copyWith(
                                      color: AppColors.cWhite,
                                      fontFamily: AppFonts.qabasFontFamily,
                                    ),
                                  ),
                                  Text(
                                    getTotalMembersCount(cart).toString(),
                                    style: AppTypography.kLight16.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.cBlack),
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
                );

          }),
        ));
  }
}
