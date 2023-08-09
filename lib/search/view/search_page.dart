import 'package:diction/search/cubit/definition_cubit.dart';
import 'package:diction/search/view/definition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        definitionSearchBar(context),
        const SizedBox(
          height: 45,
        ),
        BlocBuilder<DefinitionCubit, DefinitionState>(
          builder: (context, state) => DefinitionView(state: state),
        ),
      ],
    );
  }

  Widget definitionSearchBar(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (value) {
        context.read<DefinitionCubit>().fetchDefinition(value);
        _controller.clear();
      },
      decoration: InputDecoration(
        hintText: 'Search word',
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey.shade500,
            ),
      ),
    );
  }
}
