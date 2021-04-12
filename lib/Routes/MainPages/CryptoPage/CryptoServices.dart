import 'package:http/http.dart';
import 'dart:convert';

class CryptoServices {
  late List allCryptoPriceDataList;
  Future<void> getPrices() async {
    Response allCryptoData = await get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"));
    allCryptoPriceDataList = jsonDecode(allCryptoData.body);
  }
}
