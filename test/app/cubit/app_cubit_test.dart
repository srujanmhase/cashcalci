import 'package:bloc_test/bloc_test.dart';
import 'package:cashcalci/app/cubit/app_cubit.dart';
import 'package:cashcalci/models/latest/latest.dart';
import 'package:cashcalci/models/operations.dart';
import 'package:cashcalci/models/symbols/symbols.dart';
import 'package:cashcalci/providers/rate_provider.dart';
import 'package:cashcalci/providers/symbols_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRateProvider extends Mock implements RateProvider {}

class MockSymbolProvider extends Mock implements SymbolsProvider {}

void main() {
  late AppCubit cubit;
  late RateProvider rateProvider;
  late SymbolsProvider symbolsProvider;

  var state = AppState();

  setUp(() {
    rateProvider = MockRateProvider();
    symbolsProvider = MockSymbolProvider();
    cubit = AppCubit(rateProvider, symbolsProvider);
  });

  tearDown(() => cubit.close());

  group('App Cubit Test ... ', () {
    test('Emits initial state at the begining', () {
      expect(cubit.state, state);
    });

    test('Adds input one to state', () {
      cubit.setFirstInputValue(val: 'val');
      expect(cubit.state, const AppState(ipOne: 'val'));
    });

    test('Adds input two to state', () {
      cubit.setSecondInputValue(val: 'val');
      expect(cubit.state, const AppState(ipTwo: 'val'));
    });

    test('Adds input currency to state', () {
      cubit.setInputCurrency(val: 'INR');
      expect(cubit.state, const AppState(ipCurrency: 'INR'));
    });

    test('Adds Output currency to state', () {
      cubit.setOutputCurrency(val: 'USD');
      expect(cubit.state, const AppState(opCurrency: 'USD'));
    });

    test('Adds Operation to state', () {
      cubit.setOperation(op: Operation.add);
      expect(cubit.state, const AppState(operation: Operation.add));
    });

    test('Resets to initial state', () {
      cubit.reset();
      expect(cubit.state, state);
    });

    test(
      'emits currencies when fetchSymbols is called.',
      () async {
        when(() => symbolsProvider.fetchSymbols())
            .thenAnswer((invocation) async {
          return const Symbols(
            symbols: <String, String>{
              'INR': 'Indian Rupees',
              'USD': 'United States Dollars'
            },
          );
        });

        await cubit.fetchCurrencies();

        expect(
          cubit.state,
          const AppState(
            currencies: <String, String>{
              'INR': 'Indian Rupees',
              'USD': 'United States Dollars'
            },
          ),
        );
      },
    );

    test('emits error when fetchSymbols throws an error.', () async {
      when(() => symbolsProvider.fetchSymbols())
          .thenThrow(Exception('Exception'));

      await cubit.fetchCurrencies();
      expect(
        cubit.state,
        const AppState(
          currencyFetchError: true,
        ),
      );
    });

    blocTest<AppCubit, AppState>(
      'emit calculation with conversion when all data is proper',
      build: () => cubit,
      act: (cubit) async {
        when(() => rateProvider.fetchRates(base: 'INR', symbol: 'USD'))
            .thenAnswer((invocation) async {
          return const Latest(
            rates: <String, double>{
              'USD': 1,
            },
            timestamp: 0,
          );
        });
        cubit
          ..setFirstInputValue(val: '1')
          ..setSecondInputValue(val: '1')
          ..setOperation(op: Operation.add)
          ..setInputCurrency(val: 'INR')
          ..setOutputCurrency(val: 'USD');

        await cubit.calculate();
      },
      expect: () => [
        state.copyWith(ipOne: '1'),
        state.copyWith(ipOne: '1', ipTwo: '1'),
        state.copyWith(ipOne: '1', ipTwo: '1', operation: Operation.add),
        state.copyWith(
          ipOne: '1',
          ipTwo: '1',
          operation: Operation.add,
          ipCurrency: 'INR',
        ),
        state.copyWith(
          ipOne: '1',
          ipTwo: '1',
          operation: Operation.add,
          ipCurrency: 'INR',
          opCurrency: 'USD',
        ),
        state.copyWith(
          ipOne: '1',
          ipTwo: '1',
          operation: Operation.add,
          ipCurrency: 'INR',
          opCurrency: 'USD',
          calculating: true,
        ),
        state.copyWith(
          ipOne: '1',
          ipTwo: '1',
          operation: Operation.add,
          ipCurrency: 'INR',
          opCurrency: 'USD',
          calculating: false,
          calculationResult: 'Adding 1 to 1 gives 2.0',
          conversionResult: 'Which converted from INR to USD amount to USD 2.0',
        )
      ],
    );

    blocTest<AppCubit, AppState>(
      'emit error when all data is not proper',
      build: () => cubit,
      act: (cubit) async {
        when(() => rateProvider.fetchRates(base: 'INR', symbol: 'USD'))
            .thenAnswer((invocation) async {
          return const Latest(
            rates: <String, double>{
              'USD': 1,
            },
            timestamp: 0,
          );
        });
        cubit
          ..setFirstInputValue(val: '1')
          ..setSecondInputValue(val: '1');
        // ..setOperation(op: Operation.add)
        // ..setInputCurrency(val: 'INR')
        // ..setOutputCurrency(val: 'USD');

        await cubit.calculate();
      },
      expect: () => [
        state.copyWith(ipOne: '1'),
        state.copyWith(ipOne: '1', ipTwo: '1'),
        state.copyWith(
          ipOne: '1',
          ipTwo: '1',
          calculating: true,
        ),
        state.copyWith(
          ipOne: '1',
          ipTwo: '1',
          operationError: true,
          ipCurrencyError: true,
          opCurrencyError: true,
        ),
      ],
    );
  });
}
