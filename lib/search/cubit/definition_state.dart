part of 'definition_cubit.dart';

enum DefinitionStatus { init, loading, success, failure, notFound }

class DefinitionState extends Equatable {
  final DefinitionStatus status;
  final Definition? definition;
  final String? error;

  const DefinitionState({
    this.status = DefinitionStatus.init,
    this.definition,
    this.error,
  });

  DefinitionState copyWith({
    DefinitionStatus? status,
    Definition? definition,
    String? error,
  }) {
    return DefinitionState(
      status: status ?? this.status,
      definition: definition,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, definition, error];
}
