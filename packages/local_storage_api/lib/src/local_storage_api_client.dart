import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageApiClient {
  static const favouritesKey = 'favourites';

  static Future<List<String>> fetchFavourites() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favouritesKey) ?? [];
  }

  Future<void> setFavourites(List<String> favs) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favouritesKey, favs);
  }
}
