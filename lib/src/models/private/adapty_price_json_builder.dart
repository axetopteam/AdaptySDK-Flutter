//
//  adapty_price_json_builder.dart
//  Adapty
//
//  Created by Aleksei Valiano on 25.11.2022.
//

part of '../adapty_price.dart';

extension AdaptyPriceJSONBuilder on AdaptyPrice {
  static AdaptyPrice fromJsonValue(Map<String, dynamic> json) {
    return AdaptyPrice._(
      json.float(_Keys.amount),
      json.stringIfPresent(_Keys.currencyCode),
      json.stringIfPresent(_Keys.currencySymbol),
      json.stringIfPresent(_Keys.localizedPrice),
    );
  }
}

class _Keys {
  static const amount = 'amount';
  static const currencyCode = 'currency_code';
  static const currencySymbol = 'currency_symbol';
  static const localizedPrice = 'localized_price';
}

extension MapExtension on Map<String, dynamic> {
  AdaptyPrice price(String key) => AdaptyPriceJSONBuilder.fromJsonValue(this[key]);

  AdaptyPrice? priceIfPresent(String key) {
    var value = this[key];
    if (value == null) return null;
    return AdaptyPriceJSONBuilder.fromJsonValue(value);
  }
}
