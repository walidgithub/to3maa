import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/zakat/domain/entities/products.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_constants.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_strings.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_typography.dart';
import 'package:flutter_laravel/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/tabs/add_zakat/add_product_view.dart';
import 'package:flutter_laravel/zakat/presentation/ui_components/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddZakatView extends StatefulWidget {
  const AddZakatView({super.key});

  @override
  State<AddZakatView> createState() => _AddZakatViewState();
}

class _AddZakatViewState extends State<AddZakatView> {
  final TextEditingController _membersCountController = TextEditingController();
  final TextEditingController _zakatValueController = TextEditingController();

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
              AppStrings.addZakat,
              style: AppTypography.kLight20
                  .copyWith(fontFamily: AppFonts.boldFontFamily),
            ),
          ),
        ),
        backgroundColor: AppColors.cWhite,
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            textFieldWidget(_membersCountController, AppStrings.membersCount,
                TextInputType.number),
            SizedBox(
              height: AppConstants.heightBetweenElements,
            ),
            textFieldWidget(_zakatValueController, AppStrings.zakatValue,
                TextInputType.number),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: ListView.separated(
                  itemCount: products.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                        height: 20.h,
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return AddProductView(
                      productName: products[index].productName!,
                      productImage: products[index].productImage!,
                      productPrice: products[index].productPrice!,
                      productDesc: products[index].productDesc!,
                    );
                  }),
            )),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 100.h,
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
                                '0',
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
                                '22',
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
                  Container(
                      width: 70.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.w, color: AppColors.cPrimary),
                        borderRadius:
                            BorderRadius.circular(AppConstants.radius),
                        color: AppColors.cWhite,
                        shape: BoxShape.rectangle,
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.save,
                          style: AppTypography.kLight14.copyWith(
                            fontFamily: AppFonts.qabasFontFamily,
                            color: AppColors.cButton,
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
