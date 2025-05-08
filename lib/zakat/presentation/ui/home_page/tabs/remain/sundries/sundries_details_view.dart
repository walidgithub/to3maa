import 'package:To3maa/zakat/domain/requests/delete_sundry_request.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/sundries/sundry_details_view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'dart:ui' as ui;

class SundriesDetailsView extends StatefulWidget {
  Function deleteSundry;
  SundriesDetailsView({super.key, required this.deleteSundry});

  @override
  State<SundriesDetailsView> createState() => _SundriesDetailsViewState();
}

class _SundriesDetailsViewState extends State<SundriesDetailsView> {

  List<SundriesResponse> sundriesList = [];

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

  Future<void> getTotalOfSundries() async {
    await ZakatCubit.get(context).getTotalOfSundries();
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
                  AppStrings.sundries.tr(),
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
                  hideLoading();
                } else if (state.zakatState == RequestState.totalSundriesLoading) {
                  showLoading();
                } else if (state.zakatState == RequestState.totalSundriesLoaded) {
                  sundriesTotal = state.sundriesTotal;
                  hideLoading();
                } else if (state.zakatState == RequestState.totalSundriesError) {
                  hideLoading();
                } else if (state.zakatState == RequestState.deleteLoading) {
                  showLoading();
                } else if (state.zakatState == RequestState.deleteError) {
                  hideLoading();
                } else if (state.zakatState == RequestState.deleteDone) {
                  getAllSundries();
                  hideLoading();
                  Navigator.of(context)
                      .pop(false);
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
                      child: sundriesList.isNotEmpty
                          ? SingleChildScrollView(
                            child: ListView.separated(
                                itemCount: sundriesList.length,
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
                                  return SundryDetailsView(
                                    index: sundriesList.length - index,
                                    sundryName: sundriesList[index].sundryName!,
                                    sundryPrice: sundriesList[index].sundryPrice!,
                                    id: sundriesList[index].id,
                                    deleteCart: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(AppStrings.warning.tr(),
                                                  style: AppTypography.kBold20),
                                              content: const Text(
                                                  AppStrings.checkToDelete),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      DeleteSundryRequest deleteSundryRequest = DeleteSundryRequest(id: sundriesList[index].id);
                                                      await ZakatCubit.get(
                                                          cartContext)
                                                          .deleteSundry(
                                                          deleteSundryRequest);
                                                      widget.deleteSundry();
                                                    },
                                                    child: Text(AppStrings.yes.tr(),
                                                        style: AppTypography
                                                            .kLight16)),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text(AppStrings.no.tr(),
                                                        style: AppTypography
                                                            .kLight16)),
                                              ],
                                            );
                                          });
                                    },
                                  );
                                }),
                          )
                          : Center(
                        child: Text(
                          AppStrings.noSundries.tr(),
                          style:
                          const TextStyle(fontFamily: AppFonts.qabasFontFamily),
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
                              AppStrings.total.tr(),
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
                                  AppStrings.defaultCurrency.tr(),
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
