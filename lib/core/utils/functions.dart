import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';

Future<bool> onBackButtonPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text(AppStrings.warning),
            content: const Text(AppStrings.closeApp),
            actions: [
              TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text(AppStrings.yes)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(AppStrings.no)),
            ],
          ),
        );
      });
  return exitApp;
}
