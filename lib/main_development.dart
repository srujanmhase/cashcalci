import 'package:cashcalci/app/app.dart';
import 'package:cashcalci/bootstrap.dart';
import 'package:cashcalci/providers/client.dart';
import 'package:cashcalci/providers/rate_provider.dart';
import 'package:cashcalci/providers/symbols_provider.dart';
import 'package:provider/provider.dart';

void main() {
  bootstrap(
    () => MultiProvider(
      providers: [
        Provider(create: (context) => Client.create()),
        ProxyProvider<Client, RateProvider>(
          update: (context, value, prev) => RateProvider(
            value.client,
          ),
        ),
        ProxyProvider<Client, SymbolsProvider>(
          update: (context, value, previous) => SymbolsProvider(
            value.client,
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
