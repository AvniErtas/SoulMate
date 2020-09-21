part of 'test_paylasimlari_bloc.dart';

abstract class TestPaylasimlariState extends Equatable {
  const TestPaylasimlariState();

  @override
  List<Object> get props => [];
}

class InitialTestPaylasimlariState extends TestPaylasimlariState {
  @override
  List<Object> get props => [];


}

class TestPaylasimlariUninitialized extends TestPaylasimlariState {
}

class TestPaylasimlariError extends TestPaylasimlariState {}

class TestPaylasimlariLoading extends TestPaylasimlariState {}

class TestPaylasimlariLoaded extends TestPaylasimlariState {
  final List<Bildirim> bildirim;

  const TestPaylasimlariLoaded({
    this.bildirim,
  });

  TestPaylasimlariLoaded copyWith({
    List<Bildirim> bildirim,
  }) {
    return TestPaylasimlariLoaded(
      bildirim: bildirim ?? this.bildirim,
    );
  }

  @override
  List<Object> get props => [bildirim];

}
