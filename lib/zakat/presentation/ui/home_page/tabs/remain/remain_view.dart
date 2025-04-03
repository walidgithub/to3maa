import 'package:To3maa/zakat/domain/requests/insert_sundry_request.dart';
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
import '../../../../../domain/entities/product_image.dart';
import '../../../../../domain/requests/insert_purchase_request.dart';
import '../../../../ui_components/loading_dialog.dart';
import '../../../../ui_components/text_field_widget.dart';
import '../../cubit/zakat_cubit.dart';
import '../../cubit/zakat_states.dart';
import '../products/product_image_view.dart';

class RemainView extends StatefulWidget {
  const RemainView({super.key});

  @override
  State<RemainView> createState() => _RemainViewState();
}

class _RemainViewState extends State<RemainView> {
  final TextEditingController _sundryNameController = TextEditingController();
  final TextEditingController _sundryPriceController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool sundries = true;

  String productImage = '';

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
                          fontWeight: FontWeight.bold, color: AppColors.cBlack),
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
            // -------------------------------------------------------------------------------
            const Divider(),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.primaryDelta! > 1.0) {
                  setState(() {
                    sundries = true;
                  });
                } else {
                  setState(() {
                    sundries = false;
                  });
                }
              },
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!sundries) {
                                setState(() {
                                  sundries = !sundries;
                                });
                              }
                            },
                            child: Container(
                              height: 70.h,
                              width: MediaQuery.sizeOf(context).width / 3,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: sundries
                                    ? AppColors.cGray
                                    : AppColors.cTransparent,
                                width: 5,
                              ))),
                              child: Center(
                                child: Text(
                                  AppStrings.sundries,
                                  style: AppTypography.kBold18
                                      .copyWith(color: AppColors.cTitle),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 45.h,
                            width: 1.5.w,
                            color: AppColors.cGray,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (sundries) {
                                setState(() {
                                  sundries = !sundries;
                                });
                              }
                            },
                            child: Container(
                              height: 70.h,
                              width: MediaQuery.sizeOf(context).width / 3,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.cTransparent,
                                  border: Border(
                                      bottom: BorderSide(
                                    color: sundries
                                        ? AppColors.cTransparent
                                        : AppColors.cGray,
                                    width: 5,
                                  ))),
                              child: Center(
                                child: Text(
                                  AppStrings.buyProducts,
                                  style: AppTypography.kBold18
                                      .copyWith(color: AppColors.cTitle),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          width: MediaQuery.sizeOf(context).width - 10.w,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: AppColors.cGray,
                            width: 1,
                          ))))
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (details.primaryDelta! > 1.0) {
                        setState(() {
                          sundries = true;
                        });
                      } else {
                        setState(() {
                          sundries = false;
                        });
                      }
                    },
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height / 1.5,
                        child: !sundries
                            ? BlocConsumer<ZakatCubit, ZakatState>(
                                listener: (context, state) async {
                                  if (state.zakatState ==
                                      RequestState.insertLoading) {
                                    showLoading();
                                  } else if (state.zakatState ==
                                      RequestState.insertError) {
                                    hideLoading();
                                  } else if (state.zakatState ==
                                      RequestState.insertDone) {
                                    hideLoading();
                                    _productQuantityController.text = "";
                                    _productNameController.text = "";
                                    _productPriceController.text = "";
                                    final snackBar = SnackBar(
                                      duration: Duration(
                                          milliseconds:
                                              AppConstants.durationOfSnackBar),
                                      content:
                                          const Text(AppStrings.successAdd),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      textFieldWidget(
                                          _productNameController,
                                          AppStrings.productName,
                                          TextInputType.text,
                                          (String textVal) {}),
                                      SizedBox(
                                        height:
                                            AppConstants.heightBetweenElements,
                                      ),
                                      textFieldWidget(
                                          _productPriceController,
                                          AppStrings.productPriceWKilo,
                                          TextInputType.number,
                                          (String textVal) {}),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      textFieldWidget(
                                          _productQuantityController,
                                          AppStrings.quantityByKilo,
                                          TextInputType.number,
                                          (String textVal) {}),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (_productPriceController.text
                                                          .trim() !=
                                                      "" &&
                                                  _productNameController.text
                                                          .trim() !=
                                                      "" &&
                                                  _productQuantityController
                                                          .text
                                                          .trim() !=
                                                      "") {
                                                InsertPurchaseRequest
                                                    insertPurchaseRequest =
                                                    InsertPurchaseRequest(
                                                        productQuantity: int.parse(
                                                            _productQuantityController
                                                                .text
                                                                .trim()),
                                                        productPrice:
                                                            _productPriceController
                                                                .text
                                                                .trim(),
                                                        productName:
                                                            _productNameController
                                                                .text
                                                                .trim(),
                                                        productImage:
                                                            productImage);
                                                ZakatCubit.get(context)
                                                    .insertPurchase(
                                                        insertPurchaseRequest);
                                              }
                                            },
                                            child: Container(
                                                width: 70.w,
                                                height: 50.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2.w,
                                                      color:
                                                          AppColors.cPrimary),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppConstants.radius),
                                                  color: AppColors.cWhite,
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    AppStrings.save,
                                                    style: AppTypography
                                                        .kLight14
                                                        .copyWith(
                                                      fontFamily: AppFonts
                                                          .qabasFontFamily,
                                                      color: AppColors.cButton,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                width: 90.w,
                                                height: 50.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2.w,
                                                      color:
                                                          AppColors.cPrimary),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppConstants.radius),
                                                  color: AppColors.cWhite,
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    AppStrings.getAll,
                                                    style: AppTypography
                                                        .kLight14
                                                        .copyWith(
                                                      fontFamily: AppFonts
                                                          .qabasFontFamily,
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
                                            padding: const EdgeInsets.only(
                                                right: 8, left: 8),
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
                                                imagePath: productImages[index]
                                                    .imagePath!,
                                                activeImage:
                                                    productImages[index]
                                                        .activeImage!,
                                                imageName: productImages[index]
                                                    .imageName!,
                                                makeActive: (String imagePath) {
                                                  productImage = imagePath;
                                                  setState(() {
                                                    for (var n
                                                        in productImages) {
                                                      n.activeImage = false;
                                                    }
                                                    productImages[index]
                                                        .activeImage = true;
                                                    _productNameController
                                                            .text =
                                                        productImages[index]
                                                            .imageName!;
                                                  });
                                                },
                                              );
                                            }),
                                      )),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : BlocConsumer<ZakatCubit, ZakatState>(
                                listener: (context, state) async {
                                  if (state.zakatState ==
                                      RequestState.insertLoading) {
                                    showLoading();
                                  } else if (state.zakatState ==
                                      RequestState.insertError) {
                                    hideLoading();
                                  } else if (state.zakatState ==
                                      RequestState.insertDone) {
                                    hideLoading();
                                    _sundryNameController.text = "";
                                    _sundryPriceController.text = "";
                                    final snackBar = SnackBar(
                                      duration: Duration(
                                          milliseconds:
                                              AppConstants.durationOfSnackBar),
                                      content:
                                          const Text(AppStrings.successAdd),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      textFieldWidget(
                                          _sundryNameController,
                                          AppStrings.sundryName,
                                          TextInputType.text,
                                          (String textVal) {}),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      textFieldWidget(
                                          _sundryPriceController,
                                          AppStrings.sundryPrice,
                                          TextInputType.number,
                                          (String textVal) {}),
                                      SizedBox(
                                        height:
                                            AppConstants.heightBetweenElements,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (_sundryPriceController.text
                                                          .trim() !=
                                                      "" &&
                                                  _sundryNameController.text
                                                          .trim() !=
                                                      "") {
                                                InsertSundryRequest
                                                    insertSundryRequest =
                                                    InsertSundryRequest(
                                                        sundryPrice:
                                                            _sundryPriceController
                                                                .text
                                                                .trim(),
                                                        sundryName:
                                                            _sundryNameController
                                                                .text
                                                                .trim());
                                                ZakatCubit.get(context)
                                                    .insertSundry(
                                                        insertSundryRequest);
                                              }
                                            },
                                            child: Container(
                                                width: 70.w,
                                                height: 50.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2.w,
                                                      color:
                                                          AppColors.cPrimary),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppConstants.radius),
                                                  color: AppColors.cWhite,
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    AppStrings.save,
                                                    style: AppTypography
                                                        .kLight14
                                                        .copyWith(
                                                      fontFamily: AppFonts
                                                          .qabasFontFamily,
                                                      color: AppColors.cButton,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                width: 90.w,
                                                height: 50.w,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2.w,
                                                      color:
                                                          AppColors.cPrimary),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppConstants.radius),
                                                  color: AppColors.cWhite,
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    AppStrings.getAll,
                                                    style: AppTypography
                                                        .kLight14
                                                        .copyWith(
                                                      fontFamily: AppFonts
                                                          .qabasFontFamily,
                                                      color: AppColors.cTitle,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
