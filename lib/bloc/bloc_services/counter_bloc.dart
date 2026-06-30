//processing
//middleMan
import 'package:broadway_bmi_cal/bloc/bloc_services/counter_event.dart';
import 'package:broadway_bmi_cal/bloc/bloc_services/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int count = 0;
  CounterBloc() : super(CounterInitial()) {
    on<CounterIncrease>((event, emit) async {
      emit(CounterLoading());
      await Future.delayed(Duration(seconds: 1));

      emit(CounterLoaded(count++));
    });
    on<CounterDecrease>((event, emit) async {
      emit(CounterLoading());
      await Future.delayed(Duration(seconds: 1));
      emit(CounterLoaded(count--));
    });
    on<CounterReset>((event, emit) {
      emit(CounterLoading());
      count = 0;
      emit(CounterLoaded(count));
    });
  }
}
