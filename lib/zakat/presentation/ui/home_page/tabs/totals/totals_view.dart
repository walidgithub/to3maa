import 'package:To3maa/zakat/presentation/shared/constant/app_assets.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/totals/dates_response.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:hijri/hijri_calendar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import '../../../../../domain/entities/cart_items.dart';
import 'export_class.dart';
import 'package:intl/intl.dart';

class TotalsView extends StatefulWidget {
  const TotalsView({super.key});

  @override
  State<TotalsView> createState() => _TotalsViewState();
}

class _TotalsViewState extends State<TotalsView> {
  List<ZakatProductsByKilosResponse> zakatByKilos = [];
  HijriCalendar hijriDate = HijriCalendar.now();
  DatesResponse? selectedDate;
  List<DatesResponse> datesList = [];
  final TextEditingController _dateController = TextEditingController();

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
    datesList = extractHijriYears(cart);

    if (datesList.isNotEmpty) {
      selectedDate = datesList[0];
    }
    super.initState();
  }

  List<DatesResponse> extractHijriYears(List<Cart> carts) {
    Set<String> uniqueYears = {};
    List<DatesResponse> datesResponseList = [];

    for (var cart in carts) {
      if (cart.hijriDate != null) {
        String? hijriYear = extractYear(cart.hijriDate!);
        if (hijriYear != null) {
          if (uniqueYears.add(hijriYear)) { // Ensuring uniqueness
            datesResponseList.add(DatesResponse(id: datesResponseList.length + 1, date: hijriYear));
          }
        }
      }
    }

    return datesResponseList;
  }

  String? extractYear(String hijriDate) {
    RegExp regex = RegExp(r"[\u0660-\u0669]{4}");
    Match? match = regex.firstMatch(hijriDate);

    if (match != null) {
      String easternArabicYear = match.group(0)!;

      return convertEasternArabicToWestern(easternArabicYear);
    }
    return null;
  }

  String convertEasternArabicToWestern(String easternArabic) {
    const easternToWestern = {
      '٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4',
      '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9'
    };

    return easternArabic.split('').map((char) => easternToWestern[char] ?? char).join();
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
        textDirection: ui.TextDirection.rtl,
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
                return Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: DropdownButton2(
                              underline: Container(),
                              value: selectedDate,
                              items: datesList.map((item) {
                                return DropdownMenuItem(
                                    value: item,
                                    child: Row(
                                      children: [
                                        Container(
                                            constraints: BoxConstraints(maxWidth: 200.w),
                                            child: Text(item.date!, style: AppTypography.kExtraLight15.copyWith(color: AppColors.cTitle))),
                                      ],
                                    ));
                              }).toList(),
                              onChanged: (selectedDateP) {
                                setState(() {
                                  selectedDateP = selectedDate;
                                });
                              },
                              dropdownSearchData: DropdownSearchData(
                                searchController: _dateController,
                                searchInnerWidgetHeight: 60,
                                searchInnerWidget: Container(
                                  height: 60,
                                  padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
                                  child: Directionality(
                                    textDirection: ui.TextDirection.rtl,
                                    child: TextField(
                                      expands: true,
                                      maxLines: null,
                                      controller: _dateController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: AppStrings.selectDate,
                                        hintStyle: AppTypography.kExtraLight14,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(AppConstants.radius),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  selectedDate = item.value as DatesResponse;
                                  var choose = selectedDate!.date!.toLowerCase();
                                  return choose.contains(searchValue.toLowerCase());
                                },
                              ),
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  _dateController.clear();
                                }
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 60.h,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppConstants.radius),
                                  border: Border.all(
                                    color: AppColors.cTitle,
                                  ),
                                  color: AppColors.cBackGround,
                                ),
                                elevation: 0,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 300.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppConstants.radius),
                                    color: AppColors.cBackGround,
                                    border: Border.all(
                                        color: AppColors.cTitle
                                    )
                                ),
                                elevation: 0,
                                offset: const Offset(0, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: Radius.circular(AppConstants.radius),
                                  thickness: MaterialStateProperty.all<double>(6),
                                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Text(AppStrings.selectDate, style: AppTypography.kLight16),
                                  SizedBox(
                                    width: 5.w,
                                  )
                                ],
                              ),
                              style: AppTypography.kLight16,
                              iconStyleData: IconStyleData(iconSize: 20.w),
                            )),
                        SizedBox(
                          width: 20.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime now = DateTime.now();
                            String formattedTime =
                            DateFormat('hh:mm ss a').format(now);

                            if (await Permission.manageExternalStorage.request().isGranted) {
                              await exportCartsAndProductsDesign(
                                  carts: cart,
                                  products: zakatByKilos,
                                  printDate: "${hijriDate.fullDate().toString()} - $formattedTime",
                                  yearOfDate: selectedDate!.date!,
                                  // ignore: use_build_context_synchronously
                                  context: context
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
