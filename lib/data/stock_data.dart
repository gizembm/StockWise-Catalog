import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

Future<List<StockItem>> loadStocks() async {
  final String response =
      await rootBundle.loadString('assets/stocks.json');
  final List data = json.decode(response);
  return data
      .map((e) => StockItem(
            id: e['id'],
            name: e['name'],
            category: e['category'],
            icon: e['icon'],
            quantity: e['quantity'],
            unit: e['unit'],
            expiryDate: DateTime.now()
                .add(Duration(days: e['daysUntilExpiry'])),
            purchaseDate: DateTime.now()
                .subtract(Duration(days: e['daysSincePurchase'])),
          ))
      .toList();
}