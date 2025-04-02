import 'package:To3maa/core/shared/constant/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/constant/app_strings.dart';

Future<bool> onBackButtonPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(AppStrings.warning,style: AppTypography.kBold18,),
            content: Text(AppStrings.closeApp,style: AppTypography.kBold16),
            actions: [
              TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(AppStrings.yes,style: AppTypography.kLight14)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(AppStrings.no,style: AppTypography.kLight14)),
            ],
          ),
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
    double tons = weightKg / 1000;
    return "ton";
  } else {
    return "kg";
  }
}
