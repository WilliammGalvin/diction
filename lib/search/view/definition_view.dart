import 'package:diction/favourites/cubit/favourites_cubit.dart';
import 'package:diction/search/cubit/definition_cubit.dart';
import 'package:diction/styles.dart';
import 'package:dictionary_api/dictionary_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefinitionView extends StatelessWidget {
  final DefinitionState state;

  const DefinitionView({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case DefinitionStatus.init:
        return initView(context);
      case DefinitionStatus.loading:
        return loadingView();
      case DefinitionStatus.success:
        return foundView(context);
      case DefinitionStatus.failure:
      case DefinitionStatus.notFound:
        return errorView(context, state.status);
    }
  }

  Widget initView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome!',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          'Search a word to begin.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget loadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget foundView(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.definition!.word.capitalize(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (state.definition!.phonetic != null)
                          Text(
                            state.definition!.phonetic!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.grey.shade500,
                                ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 55,
                  ),
                  favouriteButton(),
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.definition!.meanings.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 25.0,
                  );
                },
                itemBuilder: (context, index) {
                  DefinitionMeaning meaning = state.definition!.meanings[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meaning.partOfSpeech.capitalize(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(meaning.definition),
                      if (meaning.example != null)
                        Column(
                          children: [
                            const SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              '"${meaning.example}"',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.grey.shade500,
                                  ),
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget errorView(BuildContext context, DefinitionStatus status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Uh oh',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        status == DefinitionStatus.notFound
            ? Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: state.error!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const TextSpan(
                      text: ' not found!',
                    ),
                  ],
                ),
              )
            : Text(
                state.error!,
              ),
      ],
    );
  }

  Widget favouriteButton() {
    final word = state.definition!.word;

    return BlocBuilder<FavouritesCubit, List<String>>(
      builder: (context, state) {
        final cubit = context.read<FavouritesCubit>();
        bool isFav = cubit.isFavourited(word);

        return Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.shade900,
          ),
          child: IconButton(
            onPressed: () {
              if (isFav) {
                cubit.removeFavourite(word);
              } else {
                cubit.addFavourite(word);
              }
            },
            icon: isFav
                ? Icon(
                    Icons.star,
                    color: Theme.of(context).primaryColor,
                  )
                : const Icon(
                    Icons.star_outline,
                  ),
          ),
        );
      },
    );
  }
}
