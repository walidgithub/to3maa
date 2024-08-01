import 'package:equatable/equatable.dart';
import 'package:flutter_laravel/core/utils/enums.dart';
import 'package:flutter_laravel/zakat/domain/responses/products_respose.dart';
import 'package:flutter_laravel/zakat/domain/responses/zakat_products_respose.dart';
import 'package:flutter_laravel/zakat/domain/responses/zakat_respose.dart';

class ZakatState extends Equatable {
  final List<ProductsResponse> productsList;
  final List<ZakatResponse> zakatList;
  final List<ZakatProductsResponse> zakatProductsByKiloList;
  final List<ZakatProductsResponse> zakatProductsByZakatIdList;
  final int zakatId;
  final int zakatProductId;
  final int productId;
  final RequestState zakatState;
  final String zakatMessage;

  const ZakatState({
    this.productsList = const [],
    this.zakatList = const [],
    this.zakatProductsByKiloList = const [],
    this.zakatProductsByZakatIdList = const [],
    this.zakatId = 0,
    this.zakatProductId = 0,
    this.productId = 0,
    this.zakatState = RequestState.initialState,
    this.zakatMessage = '',
  });

  ZakatState copyWith({
    List<ProductsResponse>? productsList,
    List<ZakatResponse>? zakatList,
    List<ZakatProductsResponse>? zakatProductsByKiloList,
    List<ZakatProductsResponse>? zakatProductsByZakatIdList,
    int? zakatId,
    int? zakatProductId,
    int? productId,
    RequestState? zakatState,
    String? zakatMessage,
  }) {
    return ZakatState(
      productsList: productsList ?? this.productsList,
      zakatList: zakatList ?? this.zakatList,
      zakatProductsByKiloList:
          zakatProductsByKiloList ?? this.zakatProductsByKiloList,
      zakatProductsByZakatIdList:
          zakatProductsByZakatIdList ?? this.zakatProductsByZakatIdList,
      zakatId: zakatId ?? this.zakatId,
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
        zakatProductsByKiloList,
        zakatProductsByZakatIdList,
        zakatId,
        zakatProductId,
        productId,
        zakatState,
        zakatMessage
      ];
}
