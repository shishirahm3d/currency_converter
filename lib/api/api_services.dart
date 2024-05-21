import 'package:currency_converter/api/currencies_model.dart';
import 'package:currency_converter/api/rates_model.dart';
import 'package:currency_converter/api/app_url.dart';
import 'package:http/http.dart' as http;

Future<RatesModel> fetchRates() async {
  try {
    var response = await http.get(Uri.parse(AppUrl.ratesUrl));
    if (response.statusCode == 200) {
      final ratesModel = ratesModelFromJson(response.body);
      return ratesModel;
    } else {
      print('Failed to fetch rates: ${response.statusCode}');
      print('Please switch on your mobile data and restart the app.');
      return Future.error(
          'Please switch on your mobile data and restart the app.');
    }
  } catch (e) {
    print('Error fetching rates: $e');
    print('Please switch on your mobile data and restart the app.');
    return Future.error(
        'Please switch on your mobile data and restart the app.');
  }
}

Future<Map> fetchCurrencies() async {
  try {
    var response = await http.get(Uri.parse(AppUrl.currenciesUrl));
    if (response.statusCode == 200) {
      final allCurrencies = allCurrenciesFromJson(response.body);
      return allCurrencies;
    } else {
      // Handle non-200 status code
      print('Failed to fetch currencies: ${response.statusCode}');
      print('Please switch on your mobile data and restart the app.');
      return Future.error(
          'Please switch on your mobile data and restart the app.');
    }
  } catch (e) {
    print('Error fetching currencies: $e');
    print('Please switch on your mobile data and restart the app.');
    return Future.error(
        'Please switch on your mobile data and restart the app.');
  }
}
