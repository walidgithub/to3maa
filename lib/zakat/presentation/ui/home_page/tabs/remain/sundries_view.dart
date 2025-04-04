import 'package:To3maa/zakat/domain/models/sundries_model.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/tabs/remain/sundry_view.dart';
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
import '../../../../../domain/responses/sundries_response.dart';
import '../../../../ui_components/loading_dialog.dart';
import '../../cubit/zakat_cubit.dart';
import '../../cubit/zakat_states.dart';

class SundriesView extends StatefulWidget {
  const SundriesView({super.key});

  @override
  State<SundriesView> createState() => _SundriesViewState();
}

class _SundriesViewState extends State<SundriesView> {

  List<SundriesResponse> sundriesList = [];

  @override
  void initState() {
    getAllSundries();
    super.initState();
  }

  getAllSundries() {
    ZakatCubit.get(context).getAllSundries();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cWhite,
      child:
      Column(
        children: [
          FadeInLeft(
            duration: Duration(milliseconds: AppConstants.animation),
            child: Text(
              AppStrings.sundries,
              style: AppTypography.kLight20
                  .copyWith(fontFamily: AppFonts.boldFontFamily),
            ),
          ),
          BlocConsumer<ZakatCubit, ZakatState>(
              listener: (context, state) async {
                if (state.zakatState == RequestState.zakatLoading) {
                  showLoading();
                } else if (state.zakatState == RequestState.zakatError) {
                  hideLoading();
                } else if (state.zakatState == RequestState.zakatLoaded) {
                  sundriesList = state.sundriesList;
                  hideLoading();
                } else if (state.zakatState == RequestState.deleteLoading) {
                  showLoading();
                } else if (state.zakatState == RequestState.deleteError) {
                  hideLoading();
                } else if (state.zakatState == RequestState.deleteDone) {
                  hideLoading();
                }
              }, builder: (context, state) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height - 200.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                      child: sundriesList.isNotEmpty
                          ? ListView.separated(
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
                                return SundryView(
                                  index: sundriesList.length - index,
                                  sundryName: sundriesList[index].sundryName!,
                                  sundryPrice: sundriesList[index].sundryPrice!,
                                  id: sundriesList[index].id,
                                  deleteCart: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              title: Text(AppStrings.warning,
                                                  style: AppTypography.kBold20),
                                              content: const Text(
                                                  AppStrings.checkToDelete),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      // await ZakatCubit.get(
                                                      //     cartContext)
                                                      //     .deleteZakat(
                                                      //     deleteZakatRequest);
                                                    },
                                                    child: Text(AppStrings.yes,
                                                        style: AppTypography
                                                            .kLight16)),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text(AppStrings.no,
                                                        style: AppTypography
                                                            .kLight16)),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                );
                              })
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
                    height: 110.h,
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
