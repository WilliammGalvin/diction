import 'package:diction/search/cubit/definition_cubit.dart';
import 'package:diction/search/view/definition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefinitionScreen extends StatelessWidget {
  final String word;

  const DefinitionScreen({
    required this.word,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DefinitionCubit>();
    bloc.fetchDefinition(word);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  'Go back',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              BlocBuilder<DefinitionCubit, DefinitionState>(
                builder: (context, state) {
                  return DefinitionView(state: state);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
