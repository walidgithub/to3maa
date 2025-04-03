import 'package:To3maa/core/local_db/db_helper.dart';
import 'package:To3maa/zakat/data/data_source/zakat_datasource.dart';
import 'package:To3maa/zakat/data/repository/zakat_repository.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_all_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_product_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_purchase_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_sundry_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_zakat_products_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_products_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_purchases_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_sundries_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_zakat_products_by_kilos_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_zakat_products_by_zakat_id_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_product_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_purchase_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_sundry_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_zakat_products_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/reset_product_quantity_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/update_product_quantity_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/update_product_usecase.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // dbHelper
    sl.registerLazySingleton<DbHelper>(() => DbHelper());

    // Cubit
    sl.registerFactory(() => ZakatCubit(sl(), sl(), sl(), sl(), sl(), sl(),
        sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

    // Use Cases
    sl.registerLazySingleton<DeleteProductUseCase>(
        () => DeleteProductUseCase(sl()));

    sl.registerLazySingleton<DeleteZakatProductsUseCase>(
        () => DeleteZakatProductsUseCase(sl()));

    sl.registerLazySingleton<DeleteZakatUseCase>(
        () => DeleteZakatUseCase(sl()));

    sl.registerLazySingleton<DeleteSundryUseCase>(
            () => DeleteSundryUseCase(sl()));

    sl.registerLazySingleton<DeletePurchaseUseCase>(
            () => DeletePurchaseUseCase(sl()));

    sl.registerLazySingleton<DeleteAllZakatUseCase>(
        () => DeleteAllZakatUseCase(sl()));

    sl.registerLazySingleton<GetAllProductsUseCase>(
        () => GetAllProductsUseCase(sl()));

    sl.registerLazySingleton<GetAllZakatUseCase>(
        () => GetAllZakatUseCase(sl()));

    sl.registerLazySingleton<GetAllSundriesUseCase>(
            () => GetAllSundriesUseCase(sl()));

    sl.registerLazySingleton<GetAllPurchasesUseCase>(
            () => GetAllPurchasesUseCase(sl()));

    sl.registerLazySingleton<GetZakatProductsByKilosUseCase>(
        () => GetZakatProductsByKilosUseCase(sl()));

    sl.registerLazySingleton<GetZakatProductsByZakatIdUseCase>(
        () => GetZakatProductsByZakatIdUseCase(sl()));

    sl.registerLazySingleton<InsertProductUseCase>(
        () => InsertProductUseCase(sl()));

    sl.registerLazySingleton<InsertSundryUseCase>(
            () => InsertSundryUseCase(sl()));

    sl.registerLazySingleton<InsertPurchaseUseCase>(
            () => InsertPurchaseUseCase(sl()));

    sl.registerLazySingleton<InsertZakatProductsUseCase>(
        () => InsertZakatProductsUseCase(sl()));

    sl.registerLazySingleton<InsertZakatUseCase>(
        () => InsertZakatUseCase(sl()));

    sl.registerLazySingleton<UpdateProductUseCase>(
        () => UpdateProductUseCase(sl()));

    sl.registerLazySingleton<UpdateProductQuantityUseCase>(
        () => UpdateProductQuantityUseCase(sl()));

    sl.registerLazySingleton<ResetProductQuantityUseCase>(
        () => ResetProductQuantityUseCase(sl()));

    // Repositories
    sl.registerLazySingleton<BaseRepository>(() => ZakatRepository(sl()));

    // Local DataSource
    sl.registerLazySingleton<BaseDataSource>(() => ZakatDataSource(sl()));
  }
}
