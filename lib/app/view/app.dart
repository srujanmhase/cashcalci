import 'package:cashcalci/app/cubit/app_cubit.dart';
import 'package:cashcalci/app/view/home.dart';
import 'package:cashcalci/l10n/l10n.dart';
import 'package:cashcalci/providers/rate_provider.dart';
import 'package:cashcalci/providers/symbols_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(
        context.read<RateProvider>(),
        context.read<SymbolsProvider>(),
      ),
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomePage(),
      ),
    );
  }
}
