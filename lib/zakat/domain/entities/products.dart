import 'package:flutter_laravel/zakat/presentation/shared/constant/app_assets.dart';
import 'package:flutter_laravel/zakat/presentation/shared/constant/app_strings.dart';

class Products {
  String? productImage;
  String? productName;
  String? productPrice;
  String? productDesc;
  Products(
      {this.productImage,
      this.productName,
      this.productPrice,
      this.productDesc});
}

List<Products> products = [
  Products(
      productImage: AppAssets.package,
      productName: AppStrings.rice,
      productPrice: '30',
      productDesc: 'أرز فاخر'),
  Products(
      productImage: AppAssets.wheat,
      productName: AppStrings.wheat,
      productPrice: '30',
      productDesc: 'دقيق فاخر'),
  Products(
      productImage: AppAssets.raisins,
      productName: AppStrings.raisins,
      productPrice: '30',
      productDesc: 'زبيب فاخر'),
  Products(
      productImage: AppAssets.dates,
      productName: AppStrings.dates,
      productPrice: '30',
      productDesc: 'تمر فاخر'),
  Products(
      productImage: AppAssets.parley,
      productName: AppStrings.parley,
      productPrice: '30',
      productDesc: 'شعير فاخر'),
];
