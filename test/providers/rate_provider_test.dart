import 'package:cashcalci/models/latest/latest.dart';
import 'package:cashcalci/providers/rate_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio client;
  late RateProvider provider;

  setUp(() {
    client = MockDio();
    provider = RateProvider(client);
  });

  final map = <String, dynamic>{
    'rates': {
      'USD': 1,
    },
    'timestamp': 0
  };

  group('Rate provider ... ', () {
    test('return rates when status code is 200', () async {
      when(() => client.get<dynamic>(any())).thenAnswer((invocation) async {
        return Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: 'path'),
          data: map,
        );
      });

      final data = Latest.fromJson(map);

      final response = await provider.fetchRates(
        base: 'base',
        symbol: 'symbol',
      );

      expect(response, data);
    });

    test('throw NoConnection when DioErrorType.other', () async {
      when(() => client.get<dynamic>(any())).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: 'path'),
          type: DioErrorType.other,
        ),
      );

      final response = provider.fetchRates(
        base: 'base',
        symbol: 'symbol',
      );

      await expectLater(response, throwsA(isA<NoConnection>()));
    });

    test('throw generic Exception when =! DioErrorType.other', () async {
      when(() => client.get<dynamic>(any())).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: 'path'),
          type: DioErrorType.connectTimeout,
        ),
      );

      final response = provider.fetchRates(
        base: 'base',
        symbol: 'symbol',
      );

      await expectLater(response, throwsA(isA<Exception>()));
    });
  });
}
