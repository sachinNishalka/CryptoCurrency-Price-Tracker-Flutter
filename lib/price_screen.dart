import 'package:flutter/material.dart';
// getting coin_data file
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
// variables
  String selectedValue = 'USD';
  String? bitCoinValue = '?';
  bool isWaiting = false;
// getting values for dropdown
  List<DropdownMenuItem<String>> getSelectValues() {
    List<DropdownMenuItem<String>> valueList = [];
    for (String valueInList in currenciesList) {
      DropdownMenuItem<String> oneItem = DropdownMenuItem(
        child: Text(valueInList),
        value: valueInList,
      );
      valueList.add(oneItem);
    }
    return valueList;
  }

// getting data from api

  void getdata() async {
    try {
      CoinData coinData = CoinData();
      var rate = await coinData.getCoinData(selectedValue);
      print(rate);
      setState(() {
        bitCoinValue = rate;
      });
    } on Exception catch (e) {
      print(e);
    }
  }


  // function to create list of crypto cards

  Column cryptoCards(){
    List <cryptoWidget> cryptoWidgetList= [];
    for(String cryptoCyrrencyType in cryptoList){
      cryptoWidget oneCryptoCard = cryptoWidget(value: isWaiting ? '?' : bitCoinValue.toString(),cryptoCurrency: cryptoCyrrencyType, selectedCurrency: selectedValue, );

      cryptoWidgetList.add(oneCryptoCard);
    }

    return Column(children: cryptoWidgetList,);
  }






  @override
  void InitState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
         cryptoCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
              value: selectedValue,
              items: getSelectValues(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value.toString();
                  getdata();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class cryptoWidget extends StatelessWidget {
  const cryptoWidget(
      {required this.value,
      required this.selectedCurrency,
      required this.cryptoCurrency});

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
