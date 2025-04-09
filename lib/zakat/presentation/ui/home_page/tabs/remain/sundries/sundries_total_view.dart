import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/sundries/summed_sundry.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/sundries/sundry_total_view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../../core/shared/constant/app_typography.dart';
import '../../../../../../../core/shared/style/app_colors.dart';
import '../../../../../../../core/utils/enums.dart';
import '../../../../../../domain/responses/sundries_response.dart';
import '../../../../../ui_components/loading_dialog.dart';
import '../../../cubit/zakat_cubit.dart';
import '../../../cubit/zakat_states.dart';

class SundriesTotalView extends StatefulWidget {
  const SundriesTotalView({super.key});

  @override
  State<SundriesTotalView> createState() => _SundriesTotalViewState();
}

class _SundriesTotalViewState extends State<SundriesTotalView> {

  List<SundriesResponse> sundriesList = [];
  List<SummedSundry> sundriesTotalList = [];

  @override
  void initState() {
    getAllSundries();
    getTotalOfSundries();
    super.initState();
  }

  double sundriesTotal = 0.0;

  getAllSundries() async {
    await ZakatCubit.get(context).getAllSundries();
  }

  double getTotalSundryPrice(List<SundriesResponse> items) {
    return items.fold(0.0, (total, item) {
      final price = double.tryParse(item.sundryPrice ?? '');
      return total + (price ?? 0.0);
    });
  }

  Future<void> getTotalOfSundries() async {
    await ZakatCubit.get(context).getTotalOfSundries();
  }

  List<SummedSundry> summarizeSundries(List<SundriesResponse> sundriesList) {
    final Map<String, double> grouped = {};

    for (var item in sundriesList) {
      final name = item.sundryName ?? 'Unknown';
      final price = double.tryParse(item.sundryPrice ?? '0') ?? 0.0;

      grouped[name] = (grouped[name] ?? 0) + price;
    }

    return grouped.entries
        .map((entry) => SummedSundry(sundryName: entry.key, totalPrice: entry.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child:
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FadeInLeft(
                duration: Duration(milliseconds: AppConstants.animation),
                child: Text(
                  AppStrings.totalSundries,
                  style: AppTypography.kLight20
                      .copyWith(fontFamily: AppFonts.boldFontFamily),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2.w, color: AppColors.cPrimary),
                    borderRadius:
                    BorderRadius.circular(AppConstants.radius),
                    color: AppColors.cWhite,
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.w,
                      color: AppColors.cButton,
                    ),
                  ),
                ),
              )
            ],
          ),
          BlocConsumer<ZakatCubit, ZakatState>(
              listener: (context, state) async {
                if (state.zakatState == RequestState.sundriesLoading) {
                  showLoading();
                } else if (state.zakatState == RequestState.sundriesError) {
                  hideLoading();
                } else if (state.zakatState == RequestState.sundriesLoaded) {
                  sundriesList = state.sundriesList;
                  sundriesTotalList = summarizeSundries(sundriesList);
                  hideLoading();
                } else if (state.zakatState == RequestState.totalSundriesLoading) {
                    showLoading();
                  } else if (state.zakatState == RequestState.totalSundriesLoaded) {
                    sundriesTotal = state.sundriesTotal;
                    hideLoading();
                  } else if (state.zakatState == RequestState.totalSundriesError) {
                    hideLoading();
                }
              }, builder: (context, state) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height -50.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                      child: sundriesTotalList.isNotEmpty
                          ? SingleChildScrollView(
                            child: ListView.separated(
                                itemCount: sundriesTotalList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext cartContext, int index) =>
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                itemBuilder:
                                    (BuildContext cartContext, int index) {
                                  return SundryTotalView(
                                    sundryName: sundriesTotalList[index].sundryName,
                                    sundryTotal: sundriesTotalList[index].totalPrice,
                                  );
                                }),
                          )
                          : const Center(
                        child: Text(
                          AppStrings.noSundries,
                          style:
                          TextStyle(fontFamily: AppFonts.qabasFontFamily),
                        ),
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 50.h,
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    padding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.radius),
                      color: AppColors.cButton,
                    ),
                    child: Column(
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
                                  sundriesTotal.toString(),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.07.h,
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
