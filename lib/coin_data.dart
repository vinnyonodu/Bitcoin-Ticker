import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String currency, String crypto) async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=16D2B1ED-1E66-4E14-96E5-FFA1D914358F';
    var decodedData;

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = response.body;
      decodedData = jsonDecode(responseBody);
    } else {
      print(response.statusCode);
      throw 'Error in getting request';
    }
    return decodedData;
  }
}
