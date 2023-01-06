part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    String? ipCurrency,
    String? opCurrency,
    String? ipOne,
    String? ipTwo,
    @Default(false) bool ipOneError,
    @Default(false) bool ipTwoError,
    String? error,
    @Default(false) bool cached,
    @Default(false) bool offline,
    Map<String, String>? currencies,
    Operation? operation,
    @Default(false) bool operationError,
    @Default(false) bool ipCurrencyError,
    @Default(false) bool opCurrencyError,
    @Default(false) bool currencyFetchError,
    @Default(false) bool calculating,
    String? calculationResult,
    String? conversionResult,
  }) = _AppState;
}
