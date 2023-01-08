import 'package:cashcalci/app/cubit/app_cubit.dart';
import 'package:cashcalci/app/view/select_currency_screen.dart';
import 'package:cashcalci/constants/fontstyles.dart';
import 'package:cashcalci/models/operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _ipOneController = TextEditingController();
  final _ipTwoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 160,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ColoredBox(
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            'CashCalci',
                            style: homeHeader,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: BlocConsumer<AppCubit, AppState>(
                  listener: (context, state) {
                    _ipOneController.clear();
                    _ipTwoController.clear();
                  },
                  listenWhen: (previous, current) =>
                      previous.calculationResult != null &&
                      current.calculationResult == null,
                  builder: (context, state) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push<void>(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectCurrencies(
                                          input: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffECECEC),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                      ),
                                      border: Border.all(),
                                    ),
                                    child: Center(
                                      child: Text(
                                        state.ipCurrency ?? 'N.A.',
                                        style: currencyStyle.copyWith(
                                          color: state.ipOneError
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                      border: Border.all(
                                        color: state.ipOneError
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _ipOneController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        context
                                            .read<AppCubit>()
                                            .setFirstInputValue(
                                              val: value,
                                            );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<AppCubit>().setOperation(
                                            op: Operation.add,
                                          );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width:
                                              state.operation == Operation.add
                                                  ? 3
                                                  : 1,
                                          color: state.operationError
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text('+'),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<AppCubit>().setOperation(
                                            op: Operation.subtract,
                                          );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: state.operation ==
                                                  Operation.subtract
                                              ? 3
                                              : 1,
                                          color: state.operationError
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text('-'),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<AppCubit>().setOperation(
                                            op: Operation.multiply,
                                          );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: state.operation ==
                                                  Operation.multiply
                                              ? 3
                                              : 1,
                                          color: state.operationError
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text('*'),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<AppCubit>().setOperation(
                                            op: Operation.divide,
                                          );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: state.operation ==
                                                  Operation.divide
                                              ? 3
                                              : 1,
                                          color: state.operationError
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text('/'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push<void>(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectCurrencies(
                                          input: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffECECEC),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                      ),
                                      border: Border.all(),
                                    ),
                                    child: Center(
                                      child: Text(
                                        state.ipCurrency ?? 'N.A.',
                                        style: currencyStyle.copyWith(
                                          color: state.ipOneError
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 50,
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                      border: Border.all(
                                        color: state.ipTwoError
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _ipTwoController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        context
                                            .read<AppCubit>()
                                            .setSecondInputValue(
                                              val: value,
                                            );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push<void>(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectCurrencies(
                                      input: false,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 75,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Convert to',
                                      style: currencyStyle,
                                    ),
                                    Text(
                                      state.opCurrency ?? 'Please Select',
                                      style: currencyStyle.copyWith(
                                        color: state.opCurrencyError
                                            ? Colors.red
                                            : const Color(0Xff5E5E5E),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (state.calculating ||
                            state.calculationResult != null)
                          Positioned.fill(
                            child: ColoredBox(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
              BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (state.calculating) return;
                          if (state.calculationResult != null ||
                              state.error != null) {
                            context.read<AppCubit>().reset();
                          } else {
                            context.read<AppCubit>().calculate();
                          }
                        },
                        child: Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Text(
                              (state.calculationResult != null ||
                                      state.error != null)
                                  ? 'Reset'
                                  : state.calculating
                                      ? 'Calculating...'
                                      : 'Calculate',
                              style: ctaStyle,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        state.calculationResult ?? '',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        state.conversionResult ?? '',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        state.error ?? '',
                        textAlign: TextAlign.center,
                      ),
                      Text(state.offline ? 'Cached result' : ''),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
