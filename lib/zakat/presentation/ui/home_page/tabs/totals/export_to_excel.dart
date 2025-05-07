import 'dart:io';
import 'dart:typed_data';
import 'package:To3maa/core/shared/constant/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';

Future<void> saveExcelFile(Excel excel, BuildContext context, String dateOfYear) async {
  try {
    // Encode Excel file into bytes
    List<int>? excelBytes = excel.encode();
    if (excelBytes == null) {
      print('Error: Failed to encode Excel file.');
      return;
    }

    // Convert to Uint8List (Required for Android & iOS)
    Uint8List uint8ListBytes = Uint8List.fromList(excelBytes);

    // Get app directory for saving
    Directory? directory = await getExternalStorageDirectory();
    if (directory == null) {
      print('Error: Unable to find storage directory.');
      return;
    }

    String filePath = '${directory.path}/to3mah - $dateOfYear.xlsx';

    // Write file using Uint8List bytes
    File file = File(filePath);
    await file.writeAsBytes(uint8ListBytes);

    // Open file automatically
    OpenFile.open(filePath);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(AppStrings.fileExported.tr())),
    );

  } catch (e) {
    print('Error saving Excel file: $e');
  }
}
