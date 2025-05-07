import '../../../core/shared/constant/app_assets.dart';
import '../../../core/shared/constant/app_strings.dart';

class ProductImages {
  String? imagePath;
  String? imageName;
  bool? activeImage;
  ProductImages({this.imagePath, this.activeImage, this.imageName});
}

List<ProductImages> productImages = [
  ProductImages(
      imagePath: AppAssets.package,
      activeImage: true,
      imageName: AppStrings.package),
  ProductImages(
      imagePath: AppAssets.dates,
      activeImage: false,
      imageName: AppStrings.dates),
  ProductImages(
      imagePath: AppAssets.lentils,
      activeImage: false,
      imageName: AppStrings.lentils),
  ProductImages(
      imagePath: AppAssets.raisins,
      activeImage: false,
      imageName: AppStrings.raisins),
  ProductImages(
      imagePath: AppAssets.rice,
      activeImage: false,
      imageName: AppStrings.rice),
  ProductImages(
      imagePath: AppAssets.wheat,
      activeImage: false,
      imageName: AppStrings.wheat),
  ProductImages(
      imagePath: AppAssets.beans,
      activeImage: false,
      imageName: AppStrings.beans),
  ProductImages(
      imagePath: AppAssets.pasta,
      activeImage: false,
      imageName: AppStrings.pasta),
  ProductImages(
      imagePath: AppAssets.limaBean,
      activeImage: false,
      imageName: AppStrings.limaBean),
  ProductImages(
      imagePath: AppAssets.favaBeans,
      activeImage: false,
      imageName: AppStrings.favaBeans),
];

List<ProductImages> alreadyProducts = [];