import 'package:bloc_test/bloc_test.dart';
import 'package:cashcalci/app/cubit/app_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late AppCubit cubit;

  setUp(() {
    cubit = AppCubit();
  });
}
