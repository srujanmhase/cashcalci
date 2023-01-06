import 'package:cashcalci/app/cubit/app_cubit.dart';
import 'package:cashcalci/constants/fontstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCurrencies extends StatefulWidget {
  const SelectCurrencies({
    super.key,
    required this.input,
  });
  final bool input;
  @override
  State<SelectCurrencies> createState() => _SelectCurrenciesState();
}

class _SelectCurrenciesState extends State<SelectCurrencies> {
  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 10,
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                'Select a currency',
                style: subtitleStyle,
              ),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (widget.input) {
                    if (state.ipCurrency != null) {
                      return Navigator.of(context).pop();
                    }
                  }

                  if (state.opCurrency != null) {
                    return Navigator.of(context).pop();
                  }
                },
                listenWhen: (prev, current) => prev != current,
                builder: (context, state) {
                  if (state.currencyFetchError) {
                    return Text('Error');
                  }
                  if (state.currencies == null) {
                    return Text('Loading');
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                      itemCount: state.currencies?.length ?? 0,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (widget.input) {
                              return context.read<AppCubit>().setInputCurrency(
                                    val: state.currencies?.entries
                                            .elementAt(index)
                                            .key ??
                                        '',
                                  );
                            }
                            return context.read<AppCubit>().setOutputCurrency(
                                  val: state.currencies?.entries
                                          .elementAt(index)
                                          .key ??
                                      '',
                                );
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xffF0F0F0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text(
                                    state.currencies?.entries
                                            .elementAt(index)
                                            .key ??
                                        '',
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    state.currencies?.entries
                                            .elementAt(index)
                                            .value ??
                                        '',
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
