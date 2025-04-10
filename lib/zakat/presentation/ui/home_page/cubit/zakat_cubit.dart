import 'dart:async';

import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_purchase_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_sundry_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_product_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_purchase_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_sundry_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/reset_product_quantity_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_quantity_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_all_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_members_count_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_product_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_purchase_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_sundry_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_zakat_products_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/delete_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_products_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_purchases_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_sundries_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_all_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_members_count_by_product_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_total_of_purchases_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_total_of_sundries_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_zakat_products_by_kilos_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/get_zakat_products_by_zakat_id_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_members_count_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_product_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_purchase_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_sundry_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_zakat_products_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/insert_zakat_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/reset_product_quantity_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/update_product_quantity_usecase.dart';
import 'package:To3maa/zakat/domain/use_cases/zakat_usecase/update_product_usecase.dart';
import 'package:To3maa/zakat/presentation/ui/home_page/cubit/zakat_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/requests/insert_members_count_request.dart';
import '../../../../domain/use_cases/zakat_usecase/get_purchases_by_kilos_usecase.dart';

class ZakatCubit extends Cubit<ZakatState> {
  final DeleteProductUseCase deleteProductUseCase;
  final DeleteSundryUseCase deleteSundryUseCase;
  final DeletePurchaseUseCase deletePurchaseUseCase;
  final DeleteZakatProductsUseCase deleteZakatProductsUseCase;
  final DeleteZakatUseCase deleteZakatUseCase;
  final DeleteAllZakatUseCase deleteAllZakatUseCase;
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetAllSundriesUseCase getAllSundriesUseCase;
  final GetAllPurchasesUseCase getAllPurchasesUseCase;
  final GetAllZakatUseCase getAllZakatUseCase;
  final GetZakatProductsByKilosUseCase getZakatProductsByKilosUseCase;
  final GetPurchasesByKilosUseCase getPurchasesByKilosUseCase;
  final GetZakatProductsByZakatIdUseCase getZakatProductsByZakatIdUseCase;
  final InsertProductUseCase insertProductUseCase;
  final InsertZakatProductsUseCase insertZakatProductsUseCase;
  final InsertZakatUseCase insertZakatUseCase;
  final InsertSundryUseCase insertSundryUseCase;
  final InsertPurchaseUseCase insertPurchaseUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final UpdateProductQuantityUseCase updateProductQuantityUseCase;
  final ResetProductQuantityUseCase resetProductQuantityUseCase;
  final GetTotalOfPurchasesUseCase getTotalOfPurchasesUseCase;
  final GetTotalOfSundriesUseCase getTotalOfSundriesUseCase;
  final InsertMembersCountUseCase insertMembersCountUseCase;
  final DeleteMembersCountUseCase deleteMembersCountUseCase;
  final GetMembersByProductUseCase getMembersByProductUseCase;

  ZakatCubit(
      this.deleteProductUseCase,
      this.deleteZakatProductsUseCase,
      this.deleteZakatUseCase,
      this.deleteAllZakatUseCase,
      this.getAllProductsUseCase,
      this.getAllZakatUseCase,
      this.getZakatProductsByKilosUseCase,
      this.getZakatProductsByZakatIdUseCase,
      this.insertProductUseCase,
      this.insertZakatProductsUseCase,
      this.insertZakatUseCase,
      this.updateProductUseCase,
      this.updateProductQuantityUseCase,
      this.resetProductQuantityUseCase,
      this.insertSundryUseCase,
      this.getAllPurchasesUseCase,
      this.getAllSundriesUseCase,
      this.deletePurchaseUseCase,
      this.deleteSundryUseCase,
      this.insertPurchaseUseCase,
      this.getPurchasesByKilosUseCase,
      this.getTotalOfSundriesUseCase,
      this.insertMembersCountUseCase,
      this.deleteMembersCountUseCase,
      this.getMembersByProductUseCase,
      this.getTotalOfPurchasesUseCase)
      : super(const ZakatState());

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

  FutureOr<void> insertMembersCount(InsertMembersCount insertMembersCount) async {
    emit(state.copyWith(
        zakatState: RequestState.insertLoading, zakatMessage: '', membersCountId: 0));

    final result = await insertMembersCountUseCase(insertMembersCount);

    result.fold(
            (l) => emit(state.copyWith(
            zakatState: RequestState.insertError, zakatMessage: l.message)),
            (r) => emit(state.copyWith(
          membersCountId: r,
          zakatState: RequestState.insertDone,
        )));
  }

  FutureOr<void> insertSundry(InsertSundryRequest insertSundryRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.insertLoading, zakatMessage: '', sundryId: 0));

    final result = await insertSundryUseCase(insertSundryRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.insertError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              sundryId: r,
              zakatState: RequestState.insertDone,
            )));
  }

  FutureOr<void> insertPurchase(
      InsertPurchaseRequest insertPurchaseRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.insertLoading, zakatMessage: '', purchaseId: 0));

    final result = await insertPurchaseUseCase(insertPurchaseRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.insertError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              purchaseId: r,
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

  FutureOr<void> updateProductQuantity(
      UpdateProductQuantityRequest updateProductQuantityRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.updateLoading,
        zakatMessage: '',
        productId: 0));

    final result =
        await updateProductQuantityUseCase(updateProductQuantityRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.updateError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              productId: r,
              zakatState: RequestState.updateDone,
            )));
  }

  FutureOr<void> resetProductQuantity(
      ResetProductQuantityRequest resetProductQuantityRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.updateLoading,
        zakatMessage: '',
        productId: 0));

    final result =
        await resetProductQuantityUseCase(resetProductQuantityRequest);

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

    final result = await deleteZakatUseCase(deleteZakatRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.deleteError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              zakatId: r,
              zakatState: RequestState.deleteDone,
            )));
  }

  FutureOr<void> deleteSundry(DeleteSundryRequest deleteSundryRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.deleteLoading, zakatMessage: '', zakatId: 0));

    final result = await deleteSundryUseCase(deleteSundryRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.deleteError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              sundryId: r,
              zakatState: RequestState.deleteDone,
            )));
  }

  FutureOr<void> deletePurchase(
      DeletePurchaseRequest deletePurchaseRequest) async {
    emit(state.copyWith(
        zakatState: RequestState.deleteLoading, zakatMessage: '', zakatId: 0));

    final result = await deletePurchaseUseCase(deletePurchaseRequest);

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.deleteError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              purchaseId: r,
              zakatState: RequestState.deleteDone,
            )));
  }

  FutureOr<void> deleteAllZakat() async {
    emit(state.copyWith(
        zakatState: RequestState.deleteLoading, zakatMessage: '', zakatId: 0));

    final result = await deleteAllZakatUseCase(const NoParameters());

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

    final result = await deleteZakatProductsUseCase(deleteZakatProductsRequest);

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

  FutureOr<void> getTotalOfPurchases() async {
    emit(state.copyWith(
        zakatState: RequestState.totalPurchasesLoading,
        zakatMessage: '',
        purchasesTotal: 0.0));

    final result = await getTotalOfPurchasesUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.totalPurchasesError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              purchasesTotal: r,
              zakatState: RequestState.totalPurchasesLoaded,
            )));
  }

  FutureOr<void> getTotalOfSundries() async {
    emit(state.copyWith(
        zakatState: RequestState.totalSundriesLoading,
        zakatMessage: '',
        sundriesTotal: 0.0));

    final result = await getTotalOfSundriesUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.totalSundriesError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              sundriesTotal: r,
              zakatState: RequestState.totalSundriesLoaded,
            )));
  }

  FutureOr<void> getAllSundries() async {
    emit(state.copyWith(
        zakatState: RequestState.sundriesLoading,
        zakatMessage: '',
        zakatList: []));

    final result = await getAllSundriesUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.sundriesError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              sundriesList: r,
              zakatState: RequestState.sundriesLoaded,
            )));
  }

  FutureOr<void> getAllPurchases() async {
    emit(state.copyWith(
        zakatState: RequestState.purchasesLoading,
        zakatMessage: '',
        zakatList: []));

    final result = await getAllPurchasesUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.purchasesError, zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              purchasesList: r,
              zakatState: RequestState.purchasesLoaded,
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

  FutureOr<void> getPurchasesByKilos() async {
    emit(state.copyWith(
        zakatState: RequestState.getPurchasesByKilosLoading,
        zakatMessage: '',
        purchasesByKiloList: []));

    final result = await getPurchasesByKilosUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            zakatState: RequestState.getPurchasesByKilosError,
            zakatMessage: l.message)),
        (r) => emit(state.copyWith(
              purchasesByKiloList: r,
              zakatState: RequestState.getPurchasesByKilosLoaded,
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
