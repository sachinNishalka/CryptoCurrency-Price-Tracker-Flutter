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

const apiKey = 'EC9E782C-6F9B-4138-B02C-4D73B0827192';

class CoinData {
  // getting coin data from API
  Future getCoinData(String selectedItem) async {
    var url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$apiKey');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);
      double rate = decodedData['rate'];
      return rate.toStringAsFixed(2);
    }
  }
}
