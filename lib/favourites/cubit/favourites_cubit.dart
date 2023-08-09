import 'package:bloc/bloc.dart';
import 'package:local_storage_api/local_storage_api.dart';

class FavouritesCubit extends Cubit<List<String>> {
  final LocalStorageApiClient _localStorageApiClient;

  FavouritesCubit(List<String>? initFavourites)
      : _localStorageApiClient = LocalStorageApiClient(),
        super(initFavourites ?? []);

  bool isFavourited(String val) {
    return state.contains(val);
  }

  void addFavourite(String val) {
    List<String> favs = List.from(state)..add(val);
    _localStorageApiClient.setFavourites(favs);
    emit(favs);
  }

  void removeFavourite(String val) {
    List<String> favs = List.from(state)..remove(val);
    _localStorageApiClient.setFavourites(favs);
    emit(favs);
  }
}
