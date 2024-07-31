import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/zakat/domain/entities/products.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_constants.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_strings.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_typography.dart';
import 'package:flutter_laravel/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/tabs/products/product_view.dart';
import 'package:flutter_laravel/zakat/presentation/ui_components/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  bool addNew = false;

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return addNew ? addNewBody() : productsBody();
  }

  Widget productsBody() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.cWhite,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  iconSize: 30.w,
                  icon: const Icon(Icons.add_box_outlined),
                  onPressed: () {
                    setState(() {
                      addNew = true;
                    });
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            surfaceTintColor: Colors.transparent,
            title: FadeInLeft(
              duration: Duration(milliseconds: AppConstants.animation),
              child: Text(
                AppStrings.products,
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
                  return ProductView(
                    productName: products[index].productName!,
                    productImage: products[index].productImage!,
                    productPrice: products[index].productPrice!,
                    productDesc: products[index].productDesc!,
                  );
                }),
          ),
        ));
  }

  Widget addNewBody() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.cWhite,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  iconSize: 30.w,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      addNew = false;
                    });
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            surfaceTintColor: Colors.transparent,
            title: FadeInLeft(
              duration: Duration(milliseconds: AppConstants.animation),
              child: Text(
                AppStrings.addNew,
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
              textFieldWidget(_productNameController, AppStrings.productName,
                  TextInputType.text),
              SizedBox(
                height: AppConstants.heightBetweenElements,
              ),
              textFieldWidget(_productPriceController, AppStrings.productPrice,
                  TextInputType.text),
              SizedBox(
                height: AppConstants.heightBetweenElements,
              ),
              textFieldWidget(_productDescController, AppStrings.productDesc,
                  TextInputType.text),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 50.h,
                width: MediaQuery.sizeOf(context).width * 0.75,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius),
                  color: AppColors.cButton,
                ),
                child: Center(
                  child: Text(
                    AppStrings.save,
                    style: AppTypography.kLight16.copyWith(
                      fontFamily: AppFonts.qabasFontFamily,
                      color: AppColors.cWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
