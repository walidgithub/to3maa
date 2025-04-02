import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/constant/app_typography.dart';
import '../../../../../../core/shared/style/app_colors.dart';
import '../../../../../domain/entities/product_image.dart';
import '../../../../ui_components/text_field_widget.dart';
import '../products/product_image_view.dart';

class RemainView extends StatefulWidget {
  const RemainView({super.key});

  @override
  State<RemainView> createState() => _RemainViewState();
}

class _RemainViewState extends State<RemainView> {
  final TextEditingController _sundriesController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String productImage = '';

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cWhite,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: FadeInLeft(
          duration: Duration(milliseconds: AppConstants.animation),
          child: Text(
            AppStrings.remainTab,
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
          Row(
            children: [
              Text(
                AppStrings.remain,
                style: AppTypography.kBold18.copyWith(
                  color: AppColors.cBlack,
                  fontFamily: AppFonts.qabasFontFamily,
                ),
              ),
              Row(
                children: [
                  Text(
                    "100",
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
                        color: AppColors.cBlack),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Text(
            AppStrings.sundries,
            style: AppTypography.kLight20
                .copyWith(fontFamily: AppFonts.boldFontFamily),
          ),
          SizedBox(
            height: 10.h,
          ),
          textFieldWidget(_sundriesController, AppStrings.sundryName,
              TextInputType.text, (String textVal) {}),
          SizedBox(
            height: 10.h,
          ),
          textFieldWidget(_sundriesController, AppStrings.sundryPrice,
              TextInputType.number, (String textVal) {}),
          SizedBox(
            height: AppConstants.heightBetweenElements,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 70.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.w, color: AppColors.cPrimary),
                      borderRadius: BorderRadius.circular(
                          AppConstants.radius),
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
                    )),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 70.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.w, color: AppColors.cPrimary),
                      borderRadius: BorderRadius.circular(
                          AppConstants.radius),
                      color: AppColors.cWhite,
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.reports,
                        style: AppTypography.kLight14.copyWith(
                          fontFamily: AppFonts.qabasFontFamily,
                          color: AppColors.cTitle,
                        ),
                      ),
                    )),
              ),
            ],
          ),
          const Divider(),
          Text(
            AppStrings.buyProducts,
            style: AppTypography.kLight20
                .copyWith(fontFamily: AppFonts.boldFontFamily),
          ),
          SizedBox(
            height: 10.h,
          ),
          textFieldWidget(
              _productNameController,
              AppStrings.productName,
              TextInputType.text,
                  (String textVal) {}),
          SizedBox(
            height: AppConstants.heightBetweenElements,
          ),
          textFieldWidget(
              _productPriceController,
              AppStrings.productPriceWKilo,
              TextInputType.number,
                  (String textVal) {}),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 70.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.w, color: AppColors.cPrimary),
                      borderRadius: BorderRadius.circular(
                          AppConstants.radius),
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
                    )),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: 70.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.w, color: AppColors.cPrimary),
                      borderRadius: BorderRadius.circular(
                          AppConstants.radius),
                      color: AppColors.cWhite,
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.reports,
                        style: AppTypography.kLight14.copyWith(
                          fontFamily: AppFonts.qabasFontFamily,
                          color: AppColors.cTitle,
                        ),
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: GridView.builder(
                  padding: const EdgeInsets.only(right: 8,left: 8),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: _scrollController,
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: productImages.length,
                    itemBuilder: (_, index) {
                      return ProductImageView(
                        imagePath: productImages[index].imagePath!,
                        activeImage: productImages[index].activeImage!,
                        imageName: productImages[index].imageName!,
                        makeActive: (String imagePath) {
                          productImage = imagePath;
                          setState(() {
                            for (var n in productImages) {
                              n.activeImage = false;
                            }
                            productImages[index].activeImage = true;
                            _productNameController.text =
                            productImages[index].imageName!;
                          });
                        },
                      );
                    }),
              )),
          SizedBox(
            height: 40.h,
          )
        ],
      ),
    ),
    );
  }
}
