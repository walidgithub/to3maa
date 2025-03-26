import 'dart:io';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../domain/entities/cart_items.dart';
import '../../../../../domain/responses/zakat_products_by_kilos_response.dart';

Future<void> exportCartsAndProductsDesign({
  required List<Cart> carts,
  required List<ZakatProductsByKilosResponse> products,
}) async {
  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];

  int row = 0;

  // Headers for products table
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .value = TextCellValue('(بالكيلو) الوزن');
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
      .value = TextCellValue('بيان الأصناف');
  row++;

  // Add product rows
  for (var product in products) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
        .value = DoubleCellValue(product.sa3Weight);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
        .value = TextCellValue(product.productName);
    row++;
  }

  // Calculate totals from carts
  int sumMembers = carts.fold(0, (sum, cart) => sum + (cart.membersCount ?? 0));
  double sumZakat = carts.fold(0, (sum, cart) => sum + (double.tryParse(cart.zakatValue ?? '0') ?? 0));
  double sumRemain = carts.fold(0, (sum, cart) => sum + (double.tryParse(cart.remainValue ?? '0') ?? 0));
  String hijriDate = carts.isNotEmpty ? carts.last.hijriDate ?? '' : '';

  // Empty row
  row++;

  // Add summary fields
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .value = IntCellValue(sumMembers);
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
      .value = TextCellValue('عدد الأفراد');
  row++;

  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .value = DoubleCellValue(sumZakat);
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
      .value = TextCellValue('إجمالي الزكاة');
  row++;

  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .value = DoubleCellValue(sumRemain);
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
      .value = TextCellValue('المبلغ المتبقي');
  row++;

  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .value = TextCellValue(hijriDate);
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
      .value = TextCellValue('هجرياً');
  row++;

  // Footer note
  row++;
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .value = TextCellValue('طهُرة للصائم من اللغو والرفث وطعمة للمساكين');
  row++;
  sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      .value = TextCellValue('زكاة الفطر عام 1446 هجرياً');

  // Save in Download folder
  final downloadsDir = Directory('/storage/emulated/0/Download');
  if (await Permission.manageExternalStorage.request().isGranted ||
      await Permission.storage.request().isGranted) {
    final filePath = '${downloadsDir.path}/to3mah.xlsx';
    final file = File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);
    print('Excel file saved at: $filePath');
  } else {
    print('Permission denied');
  }
}




