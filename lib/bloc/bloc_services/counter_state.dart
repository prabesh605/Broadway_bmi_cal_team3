//loading
//error
//data
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterLoading extends CounterState {}

class CounterError extends CounterState {}

class CounterLoaded extends CounterState {
  int count;
  CounterLoaded(this.count);
}
