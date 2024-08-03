import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/zakat/domain/entities/products.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_constants.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_strings.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_typography.dart';
import 'package:flutter_laravel/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/tabs/totals/totals_products_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalsView extends StatefulWidget {
  const TotalsView({super.key});

  @override
  State<TotalsView> createState() => _TotalsViewState();
}

class _TotalsViewState extends State<TotalsView> {
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
          body: SingleChildScrollView(
            child: ListView.separated(
                itemCount: products.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                      height: 20.h,
                    ),
                itemBuilder: (BuildContext context, int index) {
                  return TotalsProductsView(
                    productName: products[index].productName,
                    productImage: products[index].productImage,
                    productPrice: products[index].productPrice,
                    productDesc: products[index].productDesc,
                  );
                }),
          ),
        ));
  }
}
