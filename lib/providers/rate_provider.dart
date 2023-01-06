import 'dart:io';

import 'package:cashcalci/models/latest/latest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RateProvider {
  const RateProvider(this.client);

  final Dio client;

  Future<Latest?> fetchRates({
    required String base,
    required String symbol,
  }) async {
    try {
      final response =
          await client.get<dynamic>('latest?symbols=$symbol&base=$base');
      if (response.statusCode == 200) {
        final data = Latest.fromJson(response.data as Map<String, dynamic>);
        return data;
      }
      return null;
    } on SocketException {
      debugPrint('socket exception');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Error');
    }
  }
}
