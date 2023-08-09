import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dictionary_api/dictionary_api.dart';

part 'definition_state.dart';

class DefinitionCubit extends Cubit<DefinitionState> {
  final DictionaryApiClient _dictionaryApiClient;

  DefinitionCubit({
    DictionaryApiClient? dictionaryApiClient,
  })  : _dictionaryApiClient = dictionaryApiClient ?? DictionaryApiClient(),
        super(const DefinitionState());

  Future<void> fetchDefinition(String word) async {
    if (word.isEmpty) return;
    emit(state.copyWith(status: DefinitionStatus.loading));

    try {
      final definition = await _dictionaryApiClient.definitionSearch(word);
      emit(state.copyWith(
        status: DefinitionStatus.success,
        definition: definition,
      ));
    } on DefinitionNotFoundFailure {
      emit(state.copyWith(
        status: DefinitionStatus.notFound,
        error: word,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DefinitionStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
