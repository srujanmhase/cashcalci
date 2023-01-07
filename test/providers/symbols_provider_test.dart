import 'dart:io';

import 'package:cashcalci/models/symbols/symbols.dart';
import 'package:cashcalci/providers/symbols_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio client;
  late SymbolsProvider provider;

  setUp(() {
    client = MockDio();
    provider = SymbolsProvider(client);
  });

  final map = {
    'symbols': {'INR': 'Indian Rupees'}
  };

  group('symbols provider test ... ', () {
    test('return symbols when status code is 200', () async {
      when(() => client.get<dynamic>(any())).thenAnswer((invocation) async {
        return Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: 'path'),
          data: map,
        );
      });
      final response = await provider.fetchSymbols();
      final data = Symbols.fromJson(map);
      expect(response, data);
    });

    test('throw socketexception', () async {
      when(() => client.get<dynamic>(any())).thenThrow(
        const SocketException('message'),
      );

      final future = provider.fetchSymbols();

      await expectLater(future, throwsA(isA<SocketException>()));
    });

    test('throw generic exception', () async {
      when(() => client.get<dynamic>(any())).thenThrow(
        Exception('message'),
      );

      final future = provider.fetchSymbols();

      await expectLater(future, throwsA(isA<Exception>()));
    });
  });
}
