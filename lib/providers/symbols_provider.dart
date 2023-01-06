import 'dart:io';

import 'package:cashcalci/models/symbols/symbols.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class SymbolsProvider {
  const SymbolsProvider(this.client);
  final Dio client;

  Future<Symbols?> fetchSymbols() async {
    try {
      final response = await client.get<dynamic>('symbols');

      if (response.statusCode == 200) {
        final data = Symbols.fromJson(response.data as Map<String, dynamic>);
        return data;
      }
      return null;
    } on SocketException {
      debugPrint('Socket Exception');
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Error');
    }
  }
}
