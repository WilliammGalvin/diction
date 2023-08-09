import 'package:dictionary_api/src/models/definition_meaning.dart';

class Definition {
  final String word;
  final List<DefinitionMeaning> meanings;
  final String? phonetic;

  Definition({
    required this.word,
    required this.meanings,
    this.phonetic,
  });
}
