//user click event
//api call
abstract class CounterEvent {}

class CounterIncrease extends CounterEvent {
  int count;
  CounterIncrease(this.count);
}

class CounterDecrease extends CounterEvent {
  int count;
  CounterDecrease(this.count);
}

class CounterReset extends CounterEvent {}
