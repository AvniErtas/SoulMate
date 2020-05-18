import 'package:equatable/equatable.dart';

import 'package:soulmate/model/test.dart';

abstract class AnaSayfaState extends Equatable {
  const AnaSayfaState();

  @override
  List<Object> get props => [];
}

class AnaSayfaUninitialized extends AnaSayfaState {

}
class InitialAnaSayfaState extends AnaSayfaState {}


class AnaSayfaError extends AnaSayfaState {}

class AnaSayfaLoading extends AnaSayfaState {}

class AnaSayfaLoaded extends AnaSayfaState {
  final List<List<Test>>  Tests;
  final bool hasReachedMax;

  const AnaSayfaLoaded({
    this.Tests,
    this.hasReachedMax,
  });

  AnaSayfaLoaded copyWith({
    List<List<Test>>  Tests,
    bool hasReachedMax,
  }) {
    return AnaSayfaLoaded(
      Tests: Tests ?? this.Tests,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [Tests, hasReachedMax];

  @override
  String toString() =>
      'TestLoaded { Tests: ${Tests.length}, hasReachedMax: $hasReachedMax }';
}