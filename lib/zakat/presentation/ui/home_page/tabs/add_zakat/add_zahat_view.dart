import 'package:To3maa/zakat/domain/requests/reset_product_quantity_request.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:To3maa/core/local_db/db_helper.dart';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/entities/cart_items.dart';
import 'package:To3maa/zakat/domain/entities/suggested_items.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_quantity_request.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_constants.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/add_zakat/add_product_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/add_zakat/suggested_view.dart';
import 'package:To3maa/zakat/presentation/ui_components/loading_dialog.dart';
import 'package:To3maa/zakat/presentation/ui_components/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

class AddZakatView extends StatefulWidget {
  const AddZakatView({super.key});

  @override
  State<AddZakatView> createState() => _AddZakatViewState();
}

class _AddZakatViewState extends State<AddZakatView> {
  final TextEditingController _membersCountController = TextEditingController();
  final TextEditingController _zakatValueController = TextEditingController();

  HijriCalendar hijriDate = HijriCalendar.now();

  bool minVal = false;
  bool minCount = false;

  @override
  void initState() {
    HijriCalendar.setLocal('ar');
    getAllZakat();
    clearData();
    super.initState();
  }

  Future<void> resetQuantity() async {
    ResetProductQuantityRequest resetProductQuantityRequest =
        (const ResetProductQuantityRequest(productQuantity: 0));
    await ZakatCubit.get(context)
        .resetProductQuantity(resetProductQuantityRequest);
  }

  double remain = 0.0;
  double allValue = 0.0;
  double allProductsValue = 0.0;

  void clearData() {
    _membersCountController.text = '';
    _zakatValueController.text = '';
    remain = 0;
    allValue = 0;
    allProductsValue = 0;
    suggestedItems.clear();
    suggested = false;
    resetQuantity();
    getAllProducts();
  }

  double getMaxProductPrice(var products) {
    if (products.isEmpty) return 0;
    return products
        .map((product) => double.tryParse(product.productPrice ?? '0') ?? 0)
        .reduce((a, b) => a < b ? a : b);
  }

  bool suggested = false;

  List<SuggestedItems> suggestedItems = [];

  Future<void> getAllProducts() async {
    await ZakatCubit.get(context).getAllProducts();
  }

  Future<void> getAllZakat() async {
    await ZakatCubit.get(context).getAllZakat();
  }

  double calcRemain(var products) {
    double allProductsValue = 0.0;
    for (var x in products) {
      double productTotal =
          double.parse(x.productPrice!) * (x.productQuantity ?? 0);
      allProductsValue = allProductsValue + productTotal;
    }
    return allProductsValue;
  }

  void getSuggested(int membersCount, int zakatValue, var products) {
    if (membersCount > 0 && zakatValue > 0) {
      double valPerMember = zakatValue / membersCount;
      suggestedItems.clear();
      for (var x in products) {
        if (valPerMember >= double.parse(x.productPrice!)) {
          suggestedItems.add(SuggestedItems(
              imageId: x.id,
              imagePath: x.productImage,
              imageDesc: x.productDesc,
              selected: false,
              imageName: x.productName));
        }
      }
      setState(() {
        suggested = true;
      });
    } else {
      setState(() {
        suggested = false;
      });
    }
    if (suggestedItems.isEmpty) {
      setState(() {
        suggested = false;
      });
    }
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
              showLoading();
            } else if (state.zakatState == RequestState.productsError) {
              hideLoading();
            } else if (state.zakatState == RequestState.productsLoaded) {
              remain = allValue - calcRemain(state.productsList);
              hideLoading();
            } else if (state.zakatState == RequestState.insertLoading) {
              showLoading();
            } else if (state.zakatState == RequestState.insertError) {
              hideLoading();
            } else if (state.zakatState == RequestState.insertDone) {
              hideLoading();
              getAllZakat();
            } else if (state.zakatState == RequestState.zakatLoading) {
              showLoading();
            } else if (state.zakatState == RequestState.zakatError) {
              hideLoading();
            } else if (state.zakatState == RequestState.zakatLoaded) {
              cartItems = state.zakatList;
              hideLoading();
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
                    TextInputType.number, (String textVal) async {
                  await resetQuantity();
                  await getAllProducts();

                  getSuggested(
                      int.parse(_membersCountController.text),
                      int.parse(_zakatValueController.text),
                      state.productsList);
                }),
                SizedBox(
                  height: AppConstants.heightBetweenElements,
                ),
                textFieldWidget(_zakatValueController, AppStrings.zakatValue,
                    TextInputType.number, (String textVal) async {
                  setState(() {
                    allValue = double.parse(textVal);
                    remain = allValue - calcRemain(state.productsList);
                  });

                  await resetQuantity();
                  await getAllProducts();

                  getSuggested(
                      int.parse(_membersCountController.text),
                      int.parse(_zakatValueController.text),
                      state.productsList);
                }),
                minVal
                    ? Text(
                        "قيمة الزكاة لم تصل الحد الى الأدنى",
                        style:
                            const TextStyle(fontFamily: AppFonts.boldFontFamily)
                                .copyWith(color: AppColors.cButton),
                      )
                    : Container(),
                minCount
                    ? Text(
                        "الكميات لا تناسب عدد الأفراد وقيمة الزكاة",
                        style:
                            const TextStyle(fontFamily: AppFonts.boldFontFamily)
                                .copyWith(color: AppColors.cButton),
                      )
                    : Container(),
                suggested
                    ? SizedBox(
                        height: 5.h,
                      )
                    : Container(),
                suggested
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppStrings.suggested,
                            style:
                                TextStyle(fontFamily: AppFonts.qabasFontFamily),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.75,
                            height: 120.h,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.w, color: AppColors.cPrimary),
                              borderRadius:
                                  BorderRadius.circular(AppConstants.radius),
                            ),
                            child: ListView.separated(
                                itemCount: suggestedItems.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                          width: 10.h,
                                        ),
                                itemBuilder: (BuildContext context, int index) {
                                  return SuggestedView(
                                    imagePath: suggestedItems[index].imagePath!,
                                    imageName: suggestedItems[index].imageName!,
                                    imageDesc: suggestedItems[index].imageDesc!,
                                    selected: suggestedItems[index].selected!,
                                    id: suggestedItems[index].imageId!,
                                    addSuggested: (int id) async {
                                      setState(() {
                                        for (var n in suggestedItems) {
                                          n.selected = false;
                                        }
                                        suggestedItems[index].selected = true;
                                      });

                                      await resetQuantity();

                                      UpdateProductQuantityRequest
                                          updateProductQuantityRequest =
                                          (UpdateProductQuantityRequest(
                                              id: suggestedItems[index].imageId!,
                                              productQuantity: int.parse(
                                                  _membersCountController
                                                      .text)));

                                      await ZakatCubit.get(context)
                                          .updateProductQuantity(
                                              updateProductQuantityRequest);

                                      await getAllProducts();
                                    },
                                  );
                                }),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                    child: state.productsList.isNotEmpty
                        ? SingleChildScrollView(
                            child: ListView.separated(
                                itemCount: state.productsList.length,
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
                                    productName:
                                        state.productsList[index].productName!,
                                    productImage:
                                        state.productsList[index].productImage!,
                                    productPrice:
                                        state.productsList[index].productPrice!,
                                    productDesc:
                                        state.productsList[index].productDesc!,
                                    productQuantity: state
                                        .productsList[index].productQuantity!,
                                    allValue: allValue,
                                    productsList: state.productsList,
                                    increaseQunatity: (int quantity) async {
                                      UpdateProductQuantityRequest
                                          updateProductQuantityRequest =
                                          (UpdateProductQuantityRequest(
                                              id: state.productsList[index].id,
                                              productQuantity: quantity));

                                      await ZakatCubit.get(context)
                                          .updateProductQuantity(
                                              updateProductQuantityRequest);

                                      setState(() {
                                        state.productsList[index]
                                            .productQuantity = quantity;
                                        remain = allValue -
                                            calcRemain(state.productsList);
                                      });
                                    },
                                    decreaseQunatity: (int quantity) async {
                                      UpdateProductQuantityRequest
                                          updateProductQuantityRequest =
                                          (UpdateProductQuantityRequest(
                                              id: state.productsList[index].id,
                                              productQuantity: quantity));

                                      await ZakatCubit.get(context)
                                          .updateProductQuantity(
                                              updateProductQuantityRequest);

                                      setState(() {
                                        state.productsList[index]
                                            .productQuantity = quantity;
                                        remain = allValue -
                                            calcRemain(state.productsList);
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
                  height: 110.h,
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
                                    remain.toString(),
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
                          GestureDetector(
                            onTap: () async {
                              if (remain >= allValue) {
                                HapticFeedback.vibrate();
                                return;
                              }

                              if (remain.isNegative) {
                                HapticFeedback.vibrate();
                                return;
                              }

                              if (double.parse(_membersCountController.text
                                          .trim()) <=
                                      0 ||
                                  double.parse(
                                          _zakatValueController.text.trim()) <=
                                      0) {
                                return;
                              }

                              var maxVal =
                                  getMaxProductPrice(state.productsList);

                              if (allValue <
                                  (maxVal *
                                      int.parse(_membersCountController.text
                                          .trim()))) {
                                HapticFeedback.vibrate();
                                setState(() {
                                  minVal = true;
                                });
                                return;
                              } else {
                                if (minVal) {
                                  setState(() {
                                    minVal = false;
                                  });
                                }
                              }

                              int totalQuantity = state.productsList.fold(
                                0,
                                    (sum, product) => sum + (product.productQuantity ?? 0),
                              );

                              if (totalQuantity < int.parse(
                                  _membersCountController.text.trim())) {
                                HapticFeedback.vibrate();
                                setState(() {
                                  minCount = true;
                                });
                                return;
                              } else {
                                if (minCount) {
                                  setState(() {
                                    minCount = false;
                                  });
                                }
                              }

                              if ((allValue - remain) <
                                  (maxVal *
                                      int.parse(_membersCountController.text
                                          .trim()))) {
                                HapticFeedback.vibrate();
                                setState(() {
                                  minCount = true;
                                });
                                return;
                              } else {
                                if (minCount) {
                                  setState(() {
                                    minCount = false;
                                  });
                                }
                              }

                              DateTime now = DateTime.now();
                              String formattedTime =
                                  DateFormat('hh:mm ss a').format(now);

                              InsertZakatRequest insertZakatRequest =
                                  InsertZakatRequest(
                                      membersCount:
                                          _membersCountController.text.trim(),
                                      zakatValue:
                                          _zakatValueController.text.trim(),
                                      hegriDate:
                                          "${hijriDate.fullDate().toString()} - $formattedTime",
                                      remainValue: remain.toString());

                              await ZakatCubit.get(context)
                                  .insertZakat(insertZakatRequest);

                              for (var x in state.productsList) {
                                if (x.productQuantity != 0) {
                                  InsertZakatProductsRequest
                                      insertZakatProductsRequest =
                                      InsertZakatProductsRequest(
                                          productDesc: x.productDesc,
                                          productImage: x.productImage,
                                          productName: x.productName,
                                          productPrice: x.productPrice,
                                          productQuantity: x.productQuantity,
                                          hegriDate:
                                              "${hijriDate.fullDate().toString()} - $formattedTime",
                                          sa3Weight: x.sa3Weight,
                                          zakatId: DbHelper.insertedNewZakat);

                                  // ignore: use_build_context_synchronously
                                  await ZakatCubit.get(context)
                                      .insertZakatProducts(
                                          insertZakatProductsRequest);

                                  x.productQuantity = 0;
                                }
                              }

                              final snackBar = SnackBar(
                                duration: Duration(
                                    milliseconds:
                                        AppConstants.durationOfSnackBar),
                                content: const Text(AppStrings.successAdd),
                              );
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

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
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.07.h,
                ),
              ],
            );
          })),
    );
  }
}
