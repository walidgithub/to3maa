import 'package:flutter_laravel/core/local_db/db_helper.dart';
import 'package:flutter_laravel/zakat/data/data_source/zakat_datasource.dart';
import 'package:flutter_laravel/zakat/data/repository/zakat_repository.dart';
import 'package:flutter_laravel/zakat/domain/repository/base_repository.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/delete_product_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/delete_zakat_products_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/delete_zakat_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/get_all_products_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/get_all_zakat_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/get_zakat_products_by_kilos_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/get_zakat_products_by_zakat_id_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/insert_product_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/insert_zakat_products_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/insert_zakat_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/update_product_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/update_zakat_products_usecase.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/zakat_usecase/update_zakat_usecase.dart';
import 'package:flutter_laravel/zakat/presentation/ui/home_page/cubit/zakat_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/preferences/app_pref.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // app prefs instance
    final sharedPrefs = await SharedPreferences.getInstance();

    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

    sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

    // dbHelper
    sl.registerLazySingleton<DbHelper>(() => DbHelper());

    // Cubit
    sl.registerFactory(() => ZakatCubit(sl(), sl(), sl(), sl(), sl(), sl(),
        sl(), sl(), sl(), sl(), sl(), sl(), sl()));

    // Use Cases
    sl.registerLazySingleton<DeleteProductUseCase>(
        () => DeleteProductUseCase(sl()));

    sl.registerLazySingleton<DeleteZakatProductsUseCase>(
        () => DeleteZakatProductsUseCase(sl()));

    sl.registerLazySingleton<DeleteZakatUseCase>(
        () => DeleteZakatUseCase(sl()));

    sl.registerLazySingleton<GetAllProductsUseCase>(
        () => GetAllProductsUseCase(sl()));

    sl.registerLazySingleton<GetAllZakatUseCase>(
        () => GetAllZakatUseCase(sl()));

    sl.registerLazySingleton<GetZakatProductsByKilosUseCase>(
        () => GetZakatProductsByKilosUseCase(sl()));

    sl.registerLazySingleton<GetZakatProductsByZakatIdUseCase>(
        () => GetZakatProductsByZakatIdUseCase(sl()));

    sl.registerLazySingleton<InsertProductUseCase>(
        () => InsertProductUseCase(sl()));

    sl.registerLazySingleton<InsertZakatProductsUseCase>(
        () => InsertZakatProductsUseCase(sl()));

    sl.registerLazySingleton<InsertZakatUseCase>(
        () => InsertZakatUseCase(sl()));

    sl.registerLazySingleton<UpdateProductUseCase>(
        () => UpdateProductUseCase(sl()));

    sl.registerLazySingleton<UpdateZakatProductsUseCase>(
        () => UpdateZakatProductsUseCase(sl()));

    sl.registerLazySingleton<UpdateZakatUseCase>(
        () => UpdateZakatUseCase(sl()));

    // Repositories
    sl.registerLazySingleton<BaseRepository>(() => ZakatRepository(sl()));

    // Local DataSource
    sl.registerLazySingleton<BaseDataSource>(() => ZakatDataSource(sl()));
  }
}