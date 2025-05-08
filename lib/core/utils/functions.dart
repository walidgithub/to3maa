import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import '../shared/constant/app_strings.dart';

Future<bool> onBackButtonPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings.warning.tr(),style: AppTypography.kBold18,),
          content: Text(AppStrings.closeApp.tr(),style: AppTypography.kBold16),
          actions: [
            TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(AppStrings.yes.tr(),style: AppTypography.kLight14)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(AppStrings.no.tr(),style: AppTypography.kLight14)),
          ],
        );
      });
  return exitApp;
}

String formatWeight(num weightKg) {
  if (weightKg >= 1000) {
    double tons = weightKg / 1000;
    return tons.toStringAsFixed(2);
  } else {
    return weightKg.toStringAsFixed(2);
  }
}

String formatWeightString(num weightKg) {
  if (weightKg >= 1000) {
    return "ton";
  } else {
    return "kg";
  }
}
