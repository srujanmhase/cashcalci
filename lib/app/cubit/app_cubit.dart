import 'package:bloc/bloc.dart';
import 'package:cashcalci/bootstrap.dart';
import 'package:cashcalci/models/latest/latest.dart';
import 'package:cashcalci/models/operations.dart';
import 'package:cashcalci/providers/rate_provider.dart';
import 'package:cashcalci/providers/symbols_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.rateProvider, this.symbolsProvider) : super(const AppState());

  final RateProvider rateProvider;
  final SymbolsProvider symbolsProvider;

  Future<void> calculate() async {
    emit(state.copyWith(calculating: true));
    final first = double.tryParse(state.ipOne ?? '');
    final second = double.tryParse(state.ipTwo ?? '');
    var errMap = <String, bool>{
      'ipCurrency': false,
      'opCurrency': false,
      'ipOne': false,
      'ipTwo': false,
      'operation': false,
    };
    if (state.ipCurrency == null) {
      errMap['ipCurrency'] = true;
    }
    if (state.opCurrency == null) {
      errMap['opCurrency'] = true;
    }
    if (state.operation == null) {
      errMap['operation'] = true;
    }
    if (first == null) {
      errMap['ipOne'] = true;
    }
    if (second == null) {
      errMap['ipTwo'] = true;
    }

    var newState = AppState(
      cached: state.cached,
      calculating: state.calculating,
      calculationResult: state.calculationResult,
      conversionResult: state.conversionResult,
      currencies: state.currencies,
      currencyFetchError: state.currencyFetchError,
      error: state.error,
      ipCurrency: state.ipCurrency,
      ipCurrencyError: state.ipCurrencyError,
      ipOne: state.ipOne,
      ipOneError: state.ipOneError,
      ipTwo: state.ipTwo,
      ipTwoError: state.ipTwoError,
      offline: state.offline,
      opCurrency: state.opCurrency,
      opCurrencyError: state.opCurrencyError,
      operation: state.operation,
      operationError: state.operationError,
    );

    for (final entry in errMap.entries) {
      if (entry.value) {
        newState = stateModifier(entry.key, newState);
      }
    }

    if (state != newState) {
      return emit(newState);
    }

    var result = 0.0;

    try {
      result = calculator(first ?? 0, second ?? 0, state.operation);
    } catch (e) {
      return emit(state.copyWith(error: 'An error occured'));
    }

    try {
      final latest = await rateProvider.fetchRates(
        base: state.ipCurrency ?? '',
        symbol: state.opCurrency ?? '',
      );
      await addRatesData(state.ipCurrency ?? '', latest);

      final value = result * (latest?.rates[state.opCurrency] ?? 0);
      final calculationResult =
          '${(state.operation ?? Operation.add).prefixString()} ${state.ipOne} ${(state.operation ?? Operation.add).suffixString()} ${state.ipTwo} gives $result';
      final conversionResult =
          'Which converted from ${state.ipCurrency} to ${state.opCurrency} amount to ${state.opCurrency} $value';
      return emit(
        state.copyWith(
          offline: false,
          calculating: false,
          calculationResult: calculationResult,
          conversionResult: conversionResult,
        ),
      );
    } on NoConnection catch (e) {
      final cacheRate = fetchRatesData(
        state.ipCurrency ?? '',
        state.opCurrency ?? '',
      );
      if (cacheRate == null) {
        return emit(
          state.copyWith(
            offline: true,
            error: 'Device is offline, data not in cache.',
          ),
        );
      }
      final value = result * cacheRate;
      final calculationResult =
          '${(state.operation ?? Operation.add).prefixString()} ${state.ipOne} ${(state.operation ?? Operation.add).suffixString()} ${state.ipTwo} gives $result';
      final conversionResult =
          'Which converted from ${state.ipCurrency} to ${state.opCurrency} amount to ${state.opCurrency} $value';
      return emit(
        state.copyWith(
          offline: true,
          calculating: false,
          calculationResult: calculationResult,
          conversionResult: conversionResult,
        ),
      );
    } catch (e) {
      return emit(state.copyWith(error: 'An error occured'));
    }
  }

  Future<void> fetchCurrencies() async {
    if (state.currencies?.isNotEmpty ?? false) {
      return emit(
        state.copyWith(
          currencies: state.currencies,
        ),
      );
    }
    try {
      final data = await symbolsProvider.fetchSymbols();
      return emit(
        state.copyWith(
          currencies: data?.symbols,
          currencyFetchError: false,
        ),
      );
    } catch (e) {
      return emit(
        state.copyWith(
          currencyFetchError: true,
        ),
      );
    }
  }

  void setFirstInputValue({required String val}) {
    return emit(
      state.copyWith(
        ipOne: val,
        ipOneError: false,
      ),
    );
  }

  void setSecondInputValue({required String val}) {
    return emit(
      state.copyWith(
        ipTwo: val,
        ipTwoError: false,
      ),
    );
  }

  void setInputCurrency({required String val}) {
    return emit(
      state.copyWith(
        ipCurrency: val,
        ipCurrencyError: false,
      ),
    );
  }

  void setOutputCurrency({required String val}) {
    return emit(
      state.copyWith(
        opCurrency: val,
        opCurrencyError: false,
      ),
    );
  }

  void setOperation({required Operation op}) {
    return emit(
      state.copyWith(
        operation: op,
        operationError: false,
      ),
    );
  }

  void reset() {
    return emit(
      state.copyWith(
        calculating: false,
        calculationResult: null,
        conversionResult: null,
        error: null,
        operation: null,
        ipOne: null,
        ipTwo: null,
      ),
    );
  }
}

AppState stateModifier(String key, AppState state) {
  switch (key) {
    case 'ipCurrency':
      return state.copyWith(
        ipCurrencyError: true,
        calculating: false,
      );
    case 'opCurrency':
      return state.copyWith(
        opCurrencyError: true,
        calculating: false,
      );
    case 'ipOne':
      return state.copyWith(
        ipOneError: true,
        calculating: false,
      );
    case 'ipTwo':
      return state.copyWith(
        ipTwoError: true,
        calculating: false,
      );
    case 'operation':
      return state.copyWith(
        operationError: true,
        calculating: false,
      );
    default:
      return state;
  }
}

double calculator(double first, double second, Operation? op) {
  switch (op) {
    case Operation.add:
      return first + second;
    case Operation.subtract:
      return first - second;
    case Operation.multiply:
      return first * second;
    case Operation.divide:
      return first / second;

    default:
      return 0;
  }
}

Future<void> addRatesData(String base, Latest? data) async {
  // await box.add({
  //   'base_c': base,
  //   'rate_c': data?.rates.entries.first.key,
  //   'rate_v': data?.rates.entries.first.value,
  //   'time': data?.timestamp,
  // });
  for (var i = 0; i < box.values.length; i++) {
    final value = box.getAt(i) as List<dynamic>;
    if (value.contains(base) && value.contains(data?.rates.entries.first.key)) {
      await box.deleteAt(i);
    }
  }
  await box.add([
    base,
    data?.rates.entries.first.key,
    data?.rates.entries.first.value,
    data?.timestamp
  ]);
}

double? fetchRatesData(String base, String rateCurrency) {
  for (final element in box.values) {
    final value = element as List<dynamic>;
    final bothExist = value.contains(base) && value.contains(rateCurrency);
    if (bothExist) {
      if (base == value[0]) {
        return value[2] as double;
      }

      final rate = 1 / (double.tryParse(value[2].toString()) ?? 0);
      return rate;
    }
  }
}
