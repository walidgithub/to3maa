import 'dart:async';

import 'package:flutter_laravel/core/utils/enums.dart';
import 'package:flutter_laravel/zakat/domain/requsts/delete_product_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/delete_zakat_products_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/delete_zakat_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/get_zakat_products_by_zakat_id_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/insert_product_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/insert_zakat_products_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/insert_zakat_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/update_product_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/update_zakat_products_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/update_zakat_request.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/base_usecase/base_usecase.dart';
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
import 'package:flutter_laravel/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZakatCubit extends Cubit<ZakatState> {
  final DeleteProductUseCase deleteProductUseCase;
  final DeleteZakatProductsUseCase deleteZakatProductsUseCase;
  final DeleteZakatUseCase deleteZakatUseCase;
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetAllZakatUseCase getAllZakatUseCase;
  final GetZakatProductsByKilosUseCase getZakatProductsByKilosUseCase;
  final GetZakatProductsByZakatIdUseCase getZakatProductsByZakatIdUseCase;
  final InsertProductUseCase insertProductUseCase;
  final InsertZakatProductsUseCase insertZakatProductsUseCase;
  final InsertZakatUseCase insertZakatUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final UpdateZakatProductsUseCase updateZakatProductsUseCase;
  final UpdateZakatUseCase updateZakatUseCase;

  ZakatCubit(
    this.deleteProductUseCase,
    this.deleteZakatProductsUseCase,
    this.deleteZakatUseCase,
    this.getAllProductsUseCase,
    this.getAllZakatUseCase,
    this.getZakatProductsByKilosUseCase,
    this.getZakatProductsByZakatIdUseCase,
    this.insertProductUseCase,
    this.insertZakatProductsUseCase,
    this.insertZakatUseCase,
    this.updateProductUseCase,
    this.updateZakatProductsUseCase,
    this.updateZakatUseCase,
  ) : super(const ZakatState());

  static ZakatCubit get(context) => BlocProvider.of(context);

  // insert data ------------------------------------------------------
  FutureOr<void> insertZakat(InsertZakatRequest insertZakatRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.insertLoading, zakatMessage: '', zakatId: 0));

    final result = await insertZakatUseCase(insertZakatRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.insertError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatId: r,
              zakatState: RequestState.insertDone,
            )));
  }

  FutureOr<void> insertZakatProducts(
      InsertZakatProductsRequest insertZakatProductsRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.insertLoading,
        zakatMessage: '',
        zakatProductId: 0));

    final result = await insertZakatProductsUseCase(insertZakatProductsRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.insertError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatProductId: r,
              zakatState: RequestState.insertDone,
            )));
  }

  FutureOr<void> insertProduct(
      InsertProductRequest insertProductRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.insertLoading,
        zakatMessage: '',
        productId: 0));

    final result = await insertProductUseCase(insertProductRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.insertError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              productId: r,
              zakatState: RequestState.insertDone,
            )));
  }

  // update data ------------------------------------------------------
  FutureOr<void> updateZakat(UpdateZakatRequest updateZakatRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.updateLoading, zakatMessage: '', zakatId: 0));

    final result = await updateProductUseCase(updateZakatRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.updateError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatId: r,
              zakatState: RequestState.updateDone,
            )));
  }

  FutureOr<void> updateZakatProducts(
      UpdateZakatProductsRequest updateZakatProductsRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.updateLoading,
        zakatMessage: '',
        zakatProductId: 0));

    final result = await updateProductUseCase(updateZakatProductsRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.updateError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatProductId: r,
              zakatState: RequestState.updateDone,
            )));
  }

  FutureOr<void> updateProduct(
      UpdateProductRequest updateProductRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.updateLoading,
        zakatMessage: '',
        productId: 0));

    final result = await updateProductUseCase(updateProductRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.updateError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              productId: r,
              zakatState: RequestState.updateDone,
            )));
  }

  // delete data ------------------------------------------------------
  FutureOr<void> deleteZakat(DeleteZakatRequest deleteZakatRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.deleteLoading, zakatMessage: '', zakatId: 0));

    final result = await deleteProductUseCase(deleteZakatRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.deleteError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatId: r,
              zakatState: RequestState.deleteDone,
            )));
  }

  FutureOr<void> deleteZakatProducts(
      DeleteZakatProductsRequest deleteZakatProductsRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.deleteLoading,
        zakatMessage: '',
        zakatProductId: 0));

    final result = await deleteProductUseCase(deleteZakatProductsRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.deleteError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatProductId: r,
              zakatState: RequestState.deleteDone,
            )));
  }

  FutureOr<void> deleteProduct(
      DeleteProductRequest deleteProductRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.deleteLoading,
        zakatMessage: '',
        productId: 0));

    final result = await deleteProductUseCase(deleteProductRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.deleteError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              productId: r,
              zakatState: RequestState.deleteDone,
            )));
  }

  // get data ---------------------------------------------------------
  FutureOr<void> getAllZakat() async {
    emit(state.copyWith(
        zakatState: RequestState.zakatLoading,
        zakatMessage: '',
        zakatList: []));

    final result = await getAllZakatUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.zakatError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatList: r,
              zakatState: RequestState.zakatLoaded,
            )));
  }

  FutureOr<void> getAllProducts() async {
    emit(state.copyWith(
        zakatState: RequestState.productsLoading,
        zakatMessage: '',
        productsList: []));

    final result = await getAllProductsUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.productsError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              productsList: r,
              zakatState: RequestState.productsLoaded,
            )));
  }

  FutureOr<void> getZakatProductsByKilos() async {
    emit(state.copyWith(
        zakatState: RequestState.getZakatProductsByKilosLoading,
        zakatMessage: '',
        zakatProductsByKiloList: []));

    final result = await getZakatProductsByKilosUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.getZakatProductsByKilosError,
            zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatProductsByKiloList: r,
              zakatState: RequestState.getZakatProductsByKilosLoaded,
            )));
  }

  FutureOr<void> getZakatProductsByZakatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.getZakatProductsByZakatIdLoading,
        zakatMessage: '',
        zakatProductsByZakatIdList: []));

    final result = await getZakatProductsByZakatIdUseCase(
        getZakatProductsByZatatIdRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.getZakatProductsByZakatIdError,
            zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatProductsByZakatIdList: r,
              zakatState: RequestState.getZakatProductsByZakatIdLoaded,
            )));
  }
}