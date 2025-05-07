import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import '../../../../../../core/shared/constant/app_typography.dart';
import '../../../../../../core/shared/constant/app_constants.dart';
import '../../../../../../core/shared/constant/app_fonts.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/shared/style/app_colors.dart';

class CheckDeleteDialog extends StatefulWidget {
  Function deleteAll;
  CheckDeleteDialog({super.key, required this.deleteAll});

  static Future<void> show(BuildContext context, Function deleteAll) async {
    final navigator = Navigator.of(context);
    await showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) => CheckDeleteDialog(deleteAll: deleteAll),
    );

    if (navigator.mounted) {
      FocusScope.of(navigator.context).requestFocus(FocusNode());
    }
  }

  static void hide(BuildContext context) => Navigator.of(context).pop();

  @override
  State<CheckDeleteDialog> createState() => _CheckDeleteDialogState();
}

class _CheckDeleteDialogState extends State<CheckDeleteDialog> {
  TextEditingController checkEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        backgroundColor: AppColors.cWhite,
        insetPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 200.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 5.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: AppColors.cPrimary),
                ),
              ),
              SizedBox(height: 20.h),
              Text(AppStrings.checkDeleteAll.tr(),
                  style:
                      AppTypography.kBold22.copyWith(color: AppColors.cGray)),
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                    text: AppStrings.writeThis.tr(),
                    style: AppTypography.kLight18
                        .copyWith(color: AppColors.cTitle, height: 1.2),
                    children: [
                      TextSpan(
                          text: AppStrings.deleteAll.tr(),
                          style: AppTypography.kBold18
                              .copyWith(color: AppColors.cButton)),
                      TextSpan(
                          text: AppStrings.toEnsureDelete.tr(),
                          style: AppTypography.kLight18
                              .copyWith(color: AppColors.cTitle)),
                    ]),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 50.w,
                      child: TextField(
                          onChanged: (done) {
                            if (checkEditingController.text.trim() ==
                                AppStrings.deleteAll.tr()) {
                              setState(() {});
                            } else {
                              setState(() {});
                            }
                          },
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          controller: checkEditingController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.cTitle),
                                borderRadius:
                                    BorderRadius.circular(AppConstants.radius),
                              ),
                              border: InputBorder.none)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (checkEditingController.text.trim() == AppStrings.deleteAll.tr()) {
                        widget.deleteAll();
                        CheckDeleteDialog.hide(context);
                      }
                    },
                    child: Container(
                        width: 90.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.w, color: AppColors.cPrimary),
                          borderRadius:
                              BorderRadius.circular(AppConstants.radius),
                          color: AppColors.cWhite,
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.checkOk.tr(),
                            style: AppTypography.kLight14.copyWith(
                              fontFamily: AppFonts.qabasFontFamily,
                              color: checkEditingController.text.trim() ==
                                      AppStrings.deleteAll.tr()
                                  ? AppColors.cButton
                                  : AppColors.cGray,
                            ),
                          ),
                        )),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      CheckDeleteDialog.hide(context);
                    },
                    child: Container(
                        width: 90.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.w, color: AppColors.cPrimary),
                          borderRadius:
                              BorderRadius.circular(AppConstants.radius),
                          color: AppColors.cWhite,
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.skip.tr(),
                            style: AppTypography.kLight14.copyWith(
                              fontFamily: AppFonts.qabasFontFamily,
                              color: AppColors.cTitle,
                            ),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
