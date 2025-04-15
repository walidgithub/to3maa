import 'package:To3maa/zakat/domain/requests/insert_sundry_request.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/purchases/purchases_details_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/purchases/purchases_total_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/sundries/sundries_details_view.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/sundries/sundries_total_view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/constant/app_typography.dart';
import '../../../../../../core/shared/style/app_colors.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../domain/entities/cart_items.dart';
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
  bool showSundries = true;
  bool showAllSundries = true;
  bool showPurchases = false;
  bool showAllPurchases = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var drawers = [];

  String productImage = '';
  double purchasesTotal = 0.0;
  double sundriesTotal = 0.0;

  int selectedDrawer = 0;

  @override
  void initState() {
    getTotalOfSundries();
    getTotalOfPurchases();
    drawers = [
      const PurchasesTotalView(),
      PurchasesDetailsView(
        deletePurchase: () {
          getTotalOfPurchases();
        },
      ),
      const SundriesTotalView(),
      SundriesDetailsView(deleteSundry: () {
        getTotalOfSundries();
      }),
    ];
    super.initState();
  }

  Future<void> getTotalOfPurchases() async {
    await ZakatCubit.get(context).getTotalOfPurchases();
  }

  Future<void> getTotalOfSundries() async {
    await ZakatCubit.get(context).getTotalOfSundries();
  }

  double getRemain() {
    double remain = 0.0;
    for (var x in cartItems) {
      remain = remain + double.parse(x.remainValue);
    }
    return remain;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: drawers[selectedDrawer]),
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
        body: BlocConsumer<ZakatCubit, ZakatState>(
          listener: (context, state) {
            if (state.zakatState == RequestState.totalSundriesLoading) {
              showLoading();
            } else if (state.zakatState == RequestState.totalSundriesLoaded) {
              sundriesTotal = state.sundriesTotal;
              hideLoading();
            } else if (state.zakatState == RequestState.totalSundriesError) {
              hideLoading();
            } else if (state.zakatState == RequestState.totalPurchasesLoading) {
              showLoading();
            } else if (state.zakatState == RequestState.totalPurchasesLoaded) {
              purchasesTotal = state.purchasesTotal;
              hideLoading();
            } else if (state.zakatState == RequestState.totalPurchasesError) {
              hideLoading();
            }
          },
          builder: (context, state) {
            return Column(
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
                          (getRemain() - sundriesTotal - purchasesTotal)
                              .toString(),
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
                                      AppStrings.purchases,
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
                                              milliseconds: AppConstants
                                                  .durationOfSnackBar),
                                          content:
                                              const Text(AppStrings.successAdd),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        getTotalOfPurchases();
                                        getTotalOfSundries();
                                      }
                                    },
                                    builder: (context, state) {
                                      return Column(
                                        children: [
                                          textFieldWidget(
                                              _productNameController,
                                              AppStrings.productName,
                                              TextInputType.text,
                                              (String textVal) {},
                                              false,
                                              false),
                                          SizedBox(
                                            height: AppConstants
                                                .heightBetweenElements,
                                          ),
                                          textFieldWidget(
                                              _productPriceController,
                                              AppStrings.productPriceWKilo,
                                              TextInputType.number,
                                              (String textVal) {},
                                              true,
                                              true),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          textFieldWidget(
                                              _productQuantityController,
                                              AppStrings.quantityByKilo,
                                              TextInputType.number,
                                              (String textVal) {},
                                              false,
                                              true),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  double? price;
                                                  double? parsedPrice = double.tryParse(_productPriceController.text.trim());
                                                  double? parsedQuantity = double.tryParse(_productQuantityController.text.trim());

                                                  if (parsedPrice != null && parsedQuantity != null) {
                                                    price = parsedPrice * parsedQuantity;
                                                  } else {
                                                    price = null;
                                                  }

                                                  if ((getRemain() -
                                                          sundriesTotal -
                                                          purchasesTotal) <
                                                      price!) {
                                                    final snackBar = SnackBar(
                                                      duration: Duration(
                                                          milliseconds: AppConstants
                                                              .durationOfSnackBar),
                                                      content:
                                                      const Text(AppStrings.creditNotEnough),
                                                    );
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(snackBar);
                                                    return;
                                                  }

                                                  if (_productPriceController
                                                              .text
                                                              .trim() !=
                                                          "" &&
                                                      _productNameController
                                                              .text
                                                              .trim() !=
                                                          "" &&
                                                      _productQuantityController
                                                              .text
                                                              .trim() !=
                                                          "") {
                                                    InsertPurchaseRequest
                                                        insertPurchaseRequest =
                                                        InsertPurchaseRequest(
                                                            productQuantity:
                                                                int.parse(
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
                                                    height: 60.w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2.w,
                                                          color: AppColors
                                                              .cPrimary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppConstants
                                                                  .radius),
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
                                                          color:
                                                              AppColors.cButton,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    selectedDrawer = 0;
                                                  });
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  scaffoldKey.currentState
                                                      ?.openDrawer();
                                                },
                                                child: Container(
                                                    width: 80.w,
                                                    height: 60.w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2.w,
                                                          color: AppColors
                                                              .cPrimary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppConstants
                                                                  .radius),
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
                                                          color:
                                                              AppColors.cTitle,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    selectedDrawer = 1;
                                                  });
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  scaffoldKey.currentState
                                                      ?.openDrawer();
                                                },
                                                child: Container(
                                                    width: 80.w,
                                                    height: 60.w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2.w,
                                                          color: AppColors
                                                              .cPrimary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppConstants
                                                                  .radius),
                                                      color: AppColors.cWhite,
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        AppStrings.getDetails,
                                                        style: AppTypography
                                                            .kLight14
                                                            .copyWith(
                                                          fontFamily: AppFonts
                                                              .qabasFontFamily,
                                                          color:
                                                              AppColors.cTitle,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                sl<ZakatCubit>()
                                                  ..getAllProducts(),
                                            child: BlocConsumer<ZakatCubit,
                                                    ZakatState>(
                                                listener:
                                                    (context, state) async {
                                              if (state.zakatState ==
                                                  RequestState
                                                      .productsLoading) {
                                                showLoading();
                                              } else if (state.zakatState ==
                                                  RequestState.productsError) {
                                                hideLoading();
                                              } else if (state.zakatState ==
                                                  RequestState.productsLoaded) {
                                                alreadyProducts.clear();
                                                for (var n
                                                    in state.productsList) {
                                                  alreadyProducts.add(
                                                      ProductImages(
                                                          activeImage: false,
                                                          imageName:
                                                              n.productName,
                                                          imagePath:
                                                              n.productImage));
                                                }
                                                hideLoading();
                                              }
                                            }, builder: (context, state) {
                                              return Expanded(
                                                  child:
                                                      alreadyProducts.isNotEmpty
                                                          ? Scrollbar(
                                                              thumbVisibility:
                                                                  true,
                                                              controller:
                                                                  _scrollController,
                                                              child: GridView
                                                                  .builder(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              8,
                                                                          left:
                                                                              8),
                                                                      scrollDirection:
                                                                          Axis
                                                                              .vertical,
                                                                      shrinkWrap:
                                                                          true,
                                                                      controller:
                                                                          _scrollController,
                                                                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                                                          maxCrossAxisExtent:
                                                                              200,
                                                                          childAspectRatio:
                                                                              1,
                                                                          crossAxisSpacing:
                                                                              20,
                                                                          mainAxisSpacing:
                                                                              20),
                                                                      itemCount:
                                                                          alreadyProducts
                                                                              .length,
                                                                      itemBuilder:
                                                                          (_, index) {
                                                                        return ProductImageView(
                                                                          imagePath:
                                                                              alreadyProducts[index].imagePath!,
                                                                          activeImage:
                                                                              alreadyProducts[index].activeImage!,
                                                                          imageName:
                                                                              alreadyProducts[index].imageName!,
                                                                          makeActive:
                                                                              (String imagePath) {
                                                                            productImage =
                                                                                imagePath;
                                                                            setState(() {
                                                                              for (var n in alreadyProducts) {
                                                                                n.activeImage = false;
                                                                              }
                                                                              alreadyProducts[index].activeImage = true;
                                                                              _productNameController.text = alreadyProducts[index].imageName!;
                                                                            });
                                                                          },
                                                                        );
                                                                      }),
                                                            )
                                                          : const Center(
                                                              child: Text(
                                                                AppStrings
                                                                    .noProducts,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        AppFonts
                                                                            .qabasFontFamily),
                                                              ),
                                                            ));
                                            }),
                                          ),
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
                                              milliseconds: AppConstants
                                                  .durationOfSnackBar),
                                          content:
                                              const Text(AppStrings.successAdd),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        getTotalOfPurchases();
                                        getTotalOfSundries();
                                      }
                                    },
                                    builder: (context, state) {
                                      return Column(
                                        children: [
                                          textFieldWidget(
                                              _sundryNameController,
                                              AppStrings.sundryName,
                                              TextInputType.text,
                                              (String textVal) {},
                                              true,
                                              true),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          textFieldWidget(
                                              _sundryPriceController,
                                              AppStrings.sundryPrice,
                                              TextInputType.number,
                                              (String textVal) {},
                                              false,
                                              true),
                                          SizedBox(
                                            height: AppConstants
                                                .heightBetweenElements,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  double? price =
                                                      double.tryParse(
                                                          _sundryPriceController
                                                              .text
                                                              .trim());
                                                  if ((getRemain() -
                                                          sundriesTotal -
                                                          purchasesTotal) <
                                                      price!) {
                                                    final snackBar = SnackBar(
                                                      duration: Duration(
                                                          milliseconds: AppConstants
                                                              .durationOfSnackBar),
                                                      content:
                                                      const Text(AppStrings.creditNotEnough),
                                                    );
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(snackBar);
                                                    return;
                                                  }
                                                  if (_sundryPriceController
                                                              .text
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
                                                    height: 60.w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2.w,
                                                          color: AppColors
                                                              .cPrimary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppConstants
                                                                  .radius),
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
                                                          color:
                                                              AppColors.cButton,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    selectedDrawer = 2;
                                                  });
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  scaffoldKey.currentState
                                                      ?.openDrawer();
                                                },
                                                child: Container(
                                                    width: 80.w,
                                                    height: 60.w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2.w,
                                                          color: AppColors
                                                              .cPrimary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppConstants
                                                                  .radius),
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
                                                          color:
                                                              AppColors.cTitle,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )),
                                              ),
                                              GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      selectedDrawer = 3;
                                                    });
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());
                                                    scaffoldKey.currentState
                                                        ?.openDrawer();
                                                  },
                                                  child: Container(
                                                      width: 80.w,
                                                      height: 60.w,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 2.w,
                                                            color: AppColors
                                                                .cPrimary),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppConstants
                                                                        .radius),
                                                        color: AppColors.cWhite,
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        AppStrings.getDetails,
                                                        style: AppTypography
                                                            .kLight14
                                                            .copyWith(
                                                          fontFamily: AppFonts
                                                              .qabasFontFamily,
                                                          color:
                                                              AppColors.cTitle,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )))),
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
            );
          },
        ),
      ),
    );
  }
}
