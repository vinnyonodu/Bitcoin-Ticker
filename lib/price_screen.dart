import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency;
  String usdRate;
  var currencyValue;
  var currencyName;
  var coinValue;
  var coinValueEth;
  var coinValueLtc;
  var ethCoin;
  var ltcCoin;

  CupertinoPicker iosPicker() {
    List<Text> cupertinoTypeList = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var cupertinoListItems = Text(currenciesList[i]);
      cupertinoTypeList.add(cupertinoListItems);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {},
      children: cupertinoTypeList,
    );
  }

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> dropdownList = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var dropdownMenuItems = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      dropdownList.add(dropdownMenuItems);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateCurrency();
        });
      },
    );
  }

  void updateCurrency() async {
    coinValue = await coinData.getCoinData(selectedCurrency, 'BTC');
    coinValueEth = await coinData.getCoinData(selectedCurrency, 'ETH');
    coinValueLtc = await coinData.getCoinData(selectedCurrency, 'LTC');
    currencyName = selectedCurrency;

    setState(() {
      double currencyValuee = coinValue['rate'];
      double currencyValueEth = coinValueEth['rate'];
      double currencyValueLtc = coinValueLtc['rate'];
      currencyValue = currencyValuee.toInt();
      ethCoin = currencyValueEth.toInt();
      ltcCoin = currencyValueLtc.toInt();
    });
  }

  void startCurrency() {
    currencyValue = 'Select';
    currencyName = 'Currency';
    ethCoin = 'Select';
    ltcCoin = 'Select';
  }

  /*Widget platformPicker() {
    if (Platform.isIOS) {
      return iosPicker();
    } else if (Platform.isAndroid) {
      return androidPicker();
    }
  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCurrency();
    getCoinData();
  }

  Map getCoinData() {
    var oneCrypto;
    for (int i = 0; i < cryptoList.length; i++) {
      oneCrypto = cryptoList[i];
      Map<String, String> cryptoMap = {oneCrypto: oneCrypto};
      print(cryptoMap);
      //return cryptoMap;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = $currencyValue $currencyName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 ETH = $ethCoin $currencyName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 LTC = $ltcCoin $currencyName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 150.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 216.0),
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iosPicker() : androidPicker(),
            ),
          ),
        ],
      ),
    );
  }
}
