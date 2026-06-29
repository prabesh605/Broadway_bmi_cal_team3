//processing
//middleMan
import 'package:broadway_bmi_cal/bloc/bloc_services/counter_event.dart';
import 'package:broadway_bmi_cal/bloc/bloc_services/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<CounterIncrease>((event, emit) async {
      emit(CounterLoading());
      await Future.delayed(Duration(seconds: 3));

      emit(CounterLoaded(event.count + 1));
      // emit(CounterError());
    });
  }
}
