import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/shared/constant/app_strings.dart';
import '../../../../../../core/utils/functions.dart';
import '../../../../../domain/entities/cart_items.dart';
import '../../../../../domain/responses/zakat_products_by_kilos_response.dart';

import 'export_to_excel.dart';

Future<void> exportCartsAndProductsDesign({
  required String printDate,
  required String yearOfDate,
  required List<Cart> carts,
  required BuildContext context,
  required List<ZakatProductsByKilosResponse> products,
}) async {
  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];

  int row = 0;

  CellStyle headerStyle = CellStyle(
    bold: true,
    fontSize: 12,
    textWrapping: TextWrapping.WrapText,
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    backgroundColorHex: ExcelColor.fromHexString("#00BCD4"),
  );

  CellStyle highlightedStyle = CellStyle(
    bold: true,
    fontSize: 12,
    textWrapping: TextWrapping.WrapText,
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    backgroundColorHex: ExcelColor.fromHexString("#fcb757"),
  );

  CellStyle normalCenterStyle = CellStyle(
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
  );

  // Headers
  var headerCells = [
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row)),
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
  ];

  headerCells[0].value = TextCellValue('(بالكيلو) الوزن');
  headerCells[1].value = TextCellValue('بيان الأصناف');

  for (var cell in headerCells) {
    cell.cellStyle = headerStyle;
  }

  row++;

  for (var product in products) {
    var weightCell =
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row));
    var nameCell =
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row));

    weightCell.value = TextCellValue(
        "${formatWeight(product.sumProductQuantity! * product.sa3Weight)
            .toString()} ${formatWeightString(product.sumProductQuantity! *
            product.sa3Weight).toString() ==
            "ton"
            ? AppStrings.ton
            : AppStrings.kilo}");
    nameCell.value = TextCellValue(product.productName);

    weightCell.cellStyle = normalCenterStyle;
    nameCell.cellStyle = normalCenterStyle;

    row++;
  }

  int sumMembers = carts.fold(0, (sum, cart) => sum + (cart.membersCount ?? 0));
  double sumZakat = carts.fold(
      0, (sum, cart) => sum + (double.tryParse(cart.zakatValue ?? '0') ?? 0));
  double sumRemain = carts.fold(
      0, (sum, cart) => sum + (double.tryParse(cart.remainValue ?? '0') ?? 0));

  row++;

  var summaryItems = [
    [sumMembers, 'عدد الأفراد'],
    [sumZakat, 'إجمالي الزكاة'],
    [sumRemain, 'المبلغ المتبقي'],
    [printDate, 'تاريخ الطباعة']
  ];

  for (var item in summaryItems) {
    var valueCell =
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row));
    var labelCell =
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row));

    valueCell.value = item[0] is int
        ? IntCellValue(item[0] as int)
        : TextCellValue(item[0].toString());
    labelCell.value = TextCellValue(item[1].toString());

    valueCell.cellStyle = highlightedStyle;
    labelCell.cellStyle = highlightedStyle;

    row++;
  }

  // Footer
  row++;

  CellStyle boldStyle = CellStyle(
      bold: true,
      fontSize: 12,
      horizontalAlign: HorizontalAlign.Center
  );

  int totalColumns = 2;

// Merge first footer row
  sheet.merge(
    CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row),
    CellIndex.indexByColumnRow(columnIndex: totalColumns - 1, rowIndex: row),
  );
  sheet
      .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .value =
      TextCellValue('طهُرة للصائم من اللغو والرفث وطعمة للمساكين');
  sheet
      .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .cellStyle = boldStyle;
  row++;

  sheet.merge(
    CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row),
    CellIndex.indexByColumnRow(columnIndex: totalColumns - 1, rowIndex: row),
  );
  sheet
      .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .value =
      TextCellValue('زكاة الفطر عام $yearOfDate هجريًا');
  sheet
      .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .cellStyle = boldStyle;

  saveExcelFile(excel ,context, yearOfDate);
}

