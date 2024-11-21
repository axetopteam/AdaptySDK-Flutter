//
//  product_reference_json_builder.dart
//  Adapty
//
//  Created by Aleksei Valiano on 25.11.2022.
//

part of '../product_reference.dart';

extension ProductReferenceJSONBuilder on ProductReference {
  dynamic get jsonValue => {
        _Keys.vendorId: vendorId,
        _Keys.adaptyProductId: _adaptyProductId,
        if (AdaptySDKNative.isIOS && promotionalOfferId != null) _Keys.promotionalOfferId: promotionalOfferId,
        if (AdaptySDKNative.isIOS && winBackOfferId != null) _Keys.winBackOfferId: winBackOfferId,
        if (AdaptySDKNative.isAndroid && basePlanId != null) _Keys.basePlanId: basePlanId,
        if (AdaptySDKNative.isAndroid && offerId != null) _Keys.offerId: offerId,
      };

  static ProductReference fromJsonValue(Map<String, dynamic> json) {
    return ProductReference._(
      json.string(_Keys.vendorId),
      json.string(_Keys.adaptyProductId),
      AdaptySDKNative.isIOS ? json.stringIfPresent(_Keys.promotionalOfferId) : null,
      AdaptySDKNative.isIOS ? json.stringIfPresent(_Keys.winBackOfferId) : null,
      AdaptySDKNative.isAndroid ? json.stringIfPresent(_Keys.basePlanId) : null,
      AdaptySDKNative.isAndroid ? json.stringIfPresent(_Keys.offerId) : null,
    );
  }
}

class _Keys {
  static const vendorId = 'vendor_product_id';
  static const adaptyProductId = 'adapty_product_id';
  static const promotionalOfferId = 'promotional_offer_id'; // iOS Only
  static const winBackOfferId = 'win_back_offer_id'; // iOS Only
  static const basePlanId = 'base_plan_id'; // Android Only
  static const offerId = 'offer_id'; // Android Only
}

extension MapExtension on Map<String, dynamic> {
  List<ProductReference> productReferenceList(String key) {
    return (this[key] as List<dynamic>).map((e) => ProductReferenceJSONBuilder.fromJsonValue(e)).toList(growable: false);
  }
}
