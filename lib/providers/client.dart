import 'package:cashcalci/constants/key.dart';
import 'package:dio/dio.dart';

class Client {
  const Client(this.client);

  factory Client.create() {
    return Client(
      Dio(
        BaseOptions(
          baseUrl: 'https://api.apilayer.com/exchangerates_data/',
          headers: <String, String>{
            'apikey': key,
          },
        ),
      ),
    );
  }
  final Dio client;
}
