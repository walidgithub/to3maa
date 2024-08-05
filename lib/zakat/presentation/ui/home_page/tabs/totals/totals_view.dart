import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laravel/core/utils/enums.dart';
import 'package:flutter_laravel/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_constants.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_strings.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_typography.dart';
import 'package:flutter_laravel/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/tabs/totals/totals_products_view.dart';
import 'package:flutter_laravel/zakat/presentation/ui_components/loading_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    super.initState();
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
              child: Text(
                AppStrings.totals,
                style: AppTypography.kLight20
                    .copyWith(fontFamily: AppFonts.boldFontFamily),
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
            return zakatByKilos.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
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
                                      productDesc:
                                          zakatByKilos[index].productDesc,
                                      sumProductQuantity: zakatByKilos[index]
                                          .sumProductQuantity!);
                                })),
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      AppStrings.noCarts,
                      style: TextStyle(fontFamily: AppFonts.qabasFontFamily),
                    ),
                  );
          }),
        ));
  }
}
