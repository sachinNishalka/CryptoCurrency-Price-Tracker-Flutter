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
    Map <String, String> cryptoPrices = {};
    for(String crypto in cryptoList){
      var url = Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedItem?apikey=$apiKey');
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {

        // this code will be the final code and initial code can be found in last commits

        String data = response.body;

        var decodedData = jsonDecode(data);
        double rate = decodedData['rate'];
        cryptoPrices[crypto] = rate.toStringAsFixed(2);
      }else{
        print(response.statusCode);
      }
    }

    return cryptoPrices;



  }


}
