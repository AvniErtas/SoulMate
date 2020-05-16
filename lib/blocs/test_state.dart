import 'package:equatable/equatable.dart';

import 'package:soulmate/model/test.dart';

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

class TestUninitialized extends TestState {
  
}


class TestError extends TestState {}

class TestLoading extends TestState {}

class TestLoaded extends TestState {
  final List<Test> Tests;
  final bool hasReachedMax;

  const TestLoaded({
    this.Tests,
    this.hasReachedMax,
  });

  TestLoaded copyWith({
    List<Test> Tests,
    bool hasReachedMax,
  }) {
    return TestLoaded(
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