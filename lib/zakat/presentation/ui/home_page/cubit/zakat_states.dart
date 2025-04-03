import 'package:To3maa/zakat/domain/responses/purchases_response.dart';
import 'package:To3maa/zakat/domain/responses/sundries_response.dart';
import 'package:equatable/equatable.dart';
import 'package:To3maa/core/utils/enums.dart';
import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';

class ZakatState extends Equatable {
  final List<ProductsResponse> productsList;
  final List<ZakatResponse> zakatList;
  final List<ZakatProductsByKilosResponse> zakatProductsByKiloList;
  final List<ZakatProductsResponse> zakatProductsByZakatIdList;
  final List<SundriesResponse> sundriesList;
  final List<PurchasesResponse> purchasesList;
  final int zakatId;
  final int sundryId;
  final int purchaseId;
  final int zakatProductId;
  final int productId;
  final RequestState zakatState;
  final String zakatMessage;

  const ZakatState({
    this.productsList = const [],
    this.zakatList = const [],
    this.sundriesList = const [],
    this.purchasesList = const [],
    this.zakatProductsByKiloList = const [],
    this.zakatProductsByZakatIdList = const [],
    this.zakatId = 0,
    this.zakatProductId = 0,
    this.productId = 0,
    this.sundryId = 0,
    this.purchaseId = 0,
    this.zakatState = RequestState.initialState,
    this.zakatMessage = '',
  });

  ZakatState copyWith({
    List<ProductsResponse>? productsList,
    List<ZakatResponse>? zakatList,
    List<SundriesResponse>? sundriesList,
    List<PurchasesResponse>? purchasesList,
    List<ZakatProductsByKilosResponse>? zakatProductsByKiloList,
    List<ZakatProductsResponse>? zakatProductsByZakatIdList,
    int? zakatId,
    int? sundryId,
    int? purchaseId,
    int? zakatProductId,
    int? productId,
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
      zakatProductsByZakatIdList:
          zakatProductsByZakatIdList ?? this.zakatProductsByZakatIdList,
      zakatId: zakatId ?? this.zakatId,
      sundryId: sundryId ?? this.sundryId,
      purchaseId: purchaseId ?? this.purchaseId,
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
        zakatProductsByZakatIdList,
        zakatId,
    sundryId,
    purchaseId,
        zakatProductId,
        productId,
        zakatState,
        zakatMessage
      ];
}
