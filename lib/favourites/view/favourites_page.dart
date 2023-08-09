import 'package:diction/definition/definition_screen.dart';
import 'package:diction/favourites/cubit/favourites_cubit.dart';
import 'package:diction/search/cubit/definition_cubit.dart';
import 'package:diction/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Favourited Words',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 25,
        ),
        favouritesList(context),
      ],
    );
  }

  Widget favouritesList(BuildContext context) {
    return BlocBuilder<FavouritesCubit, List<String>>(
      builder: (buildContext, state) {
        if (state.isEmpty) {
          return Text(
            'Add words to your favorites!',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade500,
                ),
          );
        }

        return Expanded(
          child: ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              String val = state[index];
              return favouriteBlock(context, val);
            },
          ),
        );
      },
    );
  }

  Widget favouriteBlock(BuildContext context, String val) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => DefinitionCubit(),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<FavouritesCubit>(context),
                  ),
                ],
                child: DefinitionScreen(
                  word: val,
                )),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.startToEnd,
          onDismissed: (_) =>
              context.read<FavouritesCubit>().removeFavourite(val),
          background: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(238, 82, 83, 1),
            ),
            child: const Icon(
              Icons.delete,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
            ),
            child: Text(val.capitalize()),
          ),
        ),
      ),
    );
  }
}
