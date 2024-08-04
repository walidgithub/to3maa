import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laravel/core/local_db/db_helper.dart';
import 'package:flutter_laravel/core/utils/enums.dart';
import 'package:flutter_laravel/zakat/domain/entities/products.dart';
import 'package:flutter_laravel/zakat/domain/requsts/insert_zakat_products_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/insert_zakat_request.dart';
import 'package:flutter_laravel/zakat/domain/responses/products_respose.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_constants.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_strings.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_typography.dart';
import 'package:flutter_laravel/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
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
  void initState() {
    getAllProducts();
    super.initState();
  }

  double remian = 0.0;
  double allValue = 0.0;
  double allProductsValue = 0.0;

  void clearData() {
    _membersCountController.text = '';
    _zakatValueController.text = '';
    remian = 0;
    allValue = 0;
    allProductsValue = 0;
  }

  Future<void> getAllProducts() async {
    await ZakatCubit.get(context).getAllProducts();
  }

  double calcRemian() {
    double allProductsValue = 0.0;
    for (var x in products) {
      double productTotal =
          double.parse(x.productPrice!) * (x.productQuantity ?? 0);
      allProductsValue = allProductsValue + productTotal;
    }

    return allProductsValue;
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
                AppStrings.addZakat,
                style: AppTypography.kLight20
                    .copyWith(fontFamily: AppFonts.boldFontFamily),
              ),
            ),
          ),
          backgroundColor: AppColors.cWhite,
          body: BlocConsumer<ZakatCubit, ZakatState>(
              listener: (context, state) async {
            if (state.zakatState == RequestState.productsLoading) {
            } else if (state.zakatState == RequestState.productsError) {
              print('errorrrr loaded');
            } else if (state.zakatState == RequestState.productsLoaded) {
              products = state.productsList;
              for (var x in products) {
                x.productQuantity = 0;
              }
              print('loaded');
            } else if (state.zakatState == RequestState.insertLoading) {
            } else if (state.zakatState == RequestState.insertError) {
            } else if (state.zakatState == RequestState.insertDone) {
              print('doneeeeeeeeee');
            }
          }, builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                textFieldWidget(
                    _membersCountController,
                    AppStrings.membersCount,
                    TextInputType.number,
                    (String textVal) {}),
                SizedBox(
                  height: AppConstants.heightBetweenElements,
                ),
                textFieldWidget(_zakatValueController, AppStrings.zakatValue,
                    TextInputType.number, (String textVal) {
                  setState(() {
                    allValue = double.parse(textVal);
                    remian = allValue - calcRemian();
                  });
                }),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                    child: products.isNotEmpty
                        ? SingleChildScrollView(
                            child: ListView.separated(
                                itemCount: products.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                itemBuilder: (BuildContext context, int index) {
                                  return AddProductView(
                                    productName: products[index].productName!,
                                    productImage: products[index].productImage!,
                                    productPrice: products[index].productPrice!,
                                    productDesc: products[index].productDesc!,
                                    increaseQunatity: (int quantity) {
                                      setState(() {
                                        products[index].productQuantity =
                                            quantity;
                                        remian = allValue - calcRemian();
                                      });
                                    },
                                    decreaseQunatity: (int quantity) {
                                      setState(() {
                                        products[index].productQuantity =
                                            quantity;
                                        remian = allValue - calcRemian();
                                      });
                                    },
                                  );
                                }),
                          )
                        : const Center(
                            child: Text(
                              AppStrings.noProducts,
                              style: TextStyle(
                                  fontFamily: AppFonts.qabasFontFamily),
                            ),
                          )),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 150.h,
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.radius),
                    color: AppColors.cButton,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.start,
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
                                    allValue.toString(),
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
                                    remian.toString(),
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
                          GestureDetector(
                            onTap: () async {
                              if (_membersCountController.text == '' ||
                                  _zakatValueController.text == '') {
                                return;
                              }
                              InsertZakatRequest insertZakatRequest =
                                  InsertZakatRequest(
                                      membersCount:
                                          _membersCountController.text,
                                      zakatValue: _zakatValueController.text,
                                      remainValue: remian.toString());

                              await ZakatCubit.get(context)
                                  .insertZakat(insertZakatRequest);

                              for (var x in products) {
                                InsertZakatProductsRequest
                                    insertZakatProductsRequest =
                                    InsertZakatProductsRequest(
                                        productDesc: x.productDesc,
                                        productImage: x.productImage,
                                        productName: x.productName,
                                        productPrice: x.productPrice,
                                        productQuantity: x.productQuantity,
                                        zakatId: DbHelper.insertedNewZakat);

                                // ignore: use_build_context_synchronously
                                await ZakatCubit.get(context)
                                    .insertZakatProducts(
                                        insertZakatProductsRequest);

                                x.productQuantity = 0;
                              }

                              setState(() {
                                clearData();
                              });
                            },
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
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          })),
    );
  }
}
