import 'package:To3maa/zakat/domain/responses/purchases_response.dart';
import 'package:To3maa/zakat/domain/responses/sundries_response.dart';
import 'package:equatable/equatable.dart';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';

import '../../../../domain/responses/purchases_by_kilos_response.dart';

class ZakatState extends Equatable {
  final List<ProductsResponse> productsList;
  final List<ZakatResponse> zakatList;
  final List<ZakatProductsByKilosResponse> zakatProductsByKiloList;
  final List<PurchasesByKilosResponse> purchasesByKiloList;
  final List<ZakatProductsResponse> zakatProductsByZakatIdList;
  final List<ZakatProductsResponse> zakatProductsList;
  final List<SundriesResponse> sundriesList;
  final List<PurchasesResponse> purchasesList;
  final int zakatId;
  final int membersCountId;
  final int sundryId;
  final int purchaseId;
  final int zakatProductId;
  final int productId;
  final int membersCount;
  final double sundriesTotal;
  final double purchasesTotal;
  final RequestState zakatState;
  final String zakatMessage;

  const ZakatState({
    this.productsList = const [],
    this.zakatList = const [],
    this.sundriesList = const [],
    this.purchasesList = const [],
    this.zakatProductsByKiloList = const [],
    this.purchasesByKiloList = const [],
    this.zakatProductsByZakatIdList = const [],
    this.zakatProductsList = const [],
    this.zakatId = 0,
    this.membersCountId = 0,
    this.zakatProductId = 0,
    this.productId = 0,
    this.sundryId = 0,
    this.purchaseId = 0,
    this.sundriesTotal = 0.0,
    this.purchasesTotal = 0.0,
    this.membersCount = 0,
    this.zakatState = RequestState.initialState,
    this.zakatMessage = '',
  });

  ZakatState copyWith({
    List<ProductsResponse>? productsList,
    List<ZakatResponse>? zakatList,
    List<SundriesResponse>? sundriesList,
    List<PurchasesResponse>? purchasesList,
    List<ZakatProductsByKilosResponse>? zakatProductsByKiloList,
    List<PurchasesByKilosResponse>? purchasesByKiloList,
    List<ZakatProductsResponse>? zakatProductsByZakatIdList,
    List<ZakatProductsResponse>? zakatProductsList,
    int? zakatId,
    int? membersCountId,
    int? sundryId,
    int? purchaseId,
    int? zakatProductId,
    int? productId,
    int? membersCount,
    double? sundriesTotal,
    double? purchasesTotal,
    RequestState? zakatState,
    String? zakatMessage,
  }) {
    return ZakatState(
      productsList: productsList ?? this.productsList,
      zakatList: zakatList ?? this.zakatList,
      sundriesList: sundriesList ?? this.sundriesList,
      purchasesList: purchasesList ?? this.purchasesList,
      zakatProductsByKiloList:
          zakatProductsByKiloList ?? this.zakatProductsByKiloList,
      purchasesByKiloList:
      purchasesByKiloList ?? this.purchasesByKiloList,
      zakatProductsByZakatIdList:
          zakatProductsByZakatIdList ?? this.zakatProductsByZakatIdList,
      zakatProductsList:
      zakatProductsList ?? this.zakatProductsList,
      zakatId: zakatId ?? this.zakatId,
      membersCountId: membersCountId ?? this.membersCountId,
      sundryId: sundryId ?? this.sundryId,
      purchaseId: purchaseId ?? this.purchaseId,
      membersCount: membersCount ?? this.membersCount,
      sundriesTotal: sundriesTotal ?? this.sundriesTotal,
      purchasesTotal: purchasesTotal ?? this.purchasesTotal,
      zakatProductId: zakatProductId ?? this.zakatProductId,
      productId: productId ?? this.productId,
      zakatState: zakatState ?? this.zakatState,
      zakatMessage: zakatMessage ?? this.zakatMessage,
    );
  }

  @override
  List<Object?> get props => [
        productsList,
        zakatList,
    sundriesList,
    purchasesList,
        zakatProductsByKiloList,
    purchasesByKiloList,
        zakatProductsByZakatIdList,
        zakatProductsList,
        zakatId,
    membersCountId,
    sundryId,
    purchaseId,
        zakatProductId,
        productId,
    membersCount,
    purchasesTotal,
    sundriesTotal,
        zakatState,
        zakatMessage
      ];
}
