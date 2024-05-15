class AppUrl {
  static const String baseUrl = 'https://openexchangerates.org/api/';
  static const String currenciesUrl = '${baseUrl}currencies.json?app_id=$key';
  static const String ratesUrl = '${baseUrl}latest.json?base=USD&app_id=$key';
}

//API Key from https://openexchangerates.org/account/app-ids
const String key = 'a71b4f324c784b409a7ab30ee89338c2';

//Backup API KEY
//const String key = '4158a4ee506b45b9b29c98da776624eb';