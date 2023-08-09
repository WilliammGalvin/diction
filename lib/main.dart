import 'package:diction/app.dart';
import 'package:diction/favourites/cubit/favourites_cubit.dart';
import 'package:diction/search/cubit/definition_cubit.dart';
import 'package:diction/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_api/local_storage_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final favs = await LocalStorageApiClient.fetchFavourites();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DefinitionCubit()),
          BlocProvider(create: (_) => FavouritesCubit(favs)),
        ],
        child: const App(),
      ),
    ),
  );
}
