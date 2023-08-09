import 'dart:convert';

import 'package:dictionary_api/dictionary_api.dart';
import 'package:http/http.dart' as http;

class DefinitionNotFoundFailure implements Exception {}

class DefinitionRequestFailure implements Exception {}

class DictionaryApiClient {
  static const _baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

  final http.Client _httpClient;
  final JsonDecoder _jsonDecoder;

  DictionaryApiClient({http.Client? httpClient, JsonDecoder? jsonDecoder})
      : _httpClient = httpClient ?? http.Client(),
        _jsonDecoder = jsonDecoder ?? const JsonDecoder();

  Future<Definition> definitionSearch(String word) async {
    final request = Uri.parse('$_baseUrl$word');
    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw DefinitionNotFoundFailure();
    }

    return serializeDefinition(response.body);
  }

  Definition serializeDefinition(String response) {
    String word = '';
    String? phonetic;

    List<List<DefinitionMeaning>> allMeanings =
        List.castFrom(_jsonDecoder.convert(response)).map((data) {
      if (word == '' || phonetic == '') {
        word = data['word'];

        phonetic = (List.from(data['phonetics']).isNotEmpty
            ? data['phonetics'][0]['text']
            : '');
      }

      List<DefinitionMeaning> result = List.castFrom(data['meanings'])
          .map((e) => DefinitionMeaning(
                partOfSpeech: e['partOfSpeech'] ?? '',
                definition: e['definitions'][0]['definition'] ?? '',
                example: e['definitions'][0]['example'],
              ))
          .where(
            (meaning) =>
                meaning.partOfSpeech.isNotEmpty &&
                meaning.definition.isNotEmpty,
          )
          .toList();

      return result;
    }).toList();

    List<DefinitionMeaning> meanings =
        allMeanings.expand((list) => list).toList();

    meanings.sort((a, b) => a.example == null ? 1 : -1);

    return Definition(
      word: word,
      meanings: meanings,
      phonetic: phonetic,
    );
  }
}
