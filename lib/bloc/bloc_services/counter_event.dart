//user click event
//api call
abstract class CounterEvent {}

class CounterIncrease extends CounterEvent {}

class CounterDecrease extends CounterEvent {}

class CounterReset extends CounterEvent {}
