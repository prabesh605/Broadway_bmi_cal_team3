import 'package:broadway_bmi_cal/animation/second_screen.dart';
import 'package:broadway_bmi_cal/bloc/bloc_services/counter_bloc.dart';
import 'package:broadway_bmi_cal/bloc/bloc_services/counter_event.dart';
import 'package:broadway_bmi_cal/bloc/bloc_services/counter_state.dart';
import 'package:broadway_bmi_cal/bloc/login_screen_with_bloc.dart';
import 'package:broadway_bmi_cal/state_example/cart_service.dart';
import 'package:broadway_bmi_cal/state_example/ecommerce_screen.dart';
import 'package:broadway_bmi_cal/state_example/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreenWithBloc extends StatefulWidget {
  const CounterScreenWithBloc({super.key});

  @override
  State<CounterScreenWithBloc> createState() => _CounterScreenWithBlocState();
}

class _CounterScreenWithBlocState extends State<CounterScreenWithBloc> {
  int count = 0;
  // void increment() {
  //   setState(() {
  //     count++;
  //   });
  // }

  // void decrement() {
  //   setState(() {
  //     count--;
  //   });
  // }

  @override
  Widget build(BuildContext gitcontext) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Counter"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // increment();

                    context.read<CounterBloc>().add(CounterIncrease());
                  },
                  icon: Icon(Icons.add),
                ),
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    if (state is CounterLoading) {
                      return CircularProgressIndicator();
                    } else if (state is CounterError) {
                      return Text("There is error");
                    } else if (state is CounterLoaded) {
                      return Text('${state.count}');
                    }

                    return SizedBox();
                  },
                ),
                // BlocBuilder<CounterBloc,CounterState>(
                //   builder: (context,state) {
                //     if(state is CounterLoading){

                //     }
                //     return Text("data");
                //   }
                // ),
                IconButton(
                  onPressed: () {
                    // decrement();
                    context.read<CounterBloc>().add(CounterDecrease());
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                // decrement();
                context.read<CounterBloc>().add(CounterReset());
              },
              icon: Icon(Icons.restore),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreenWithBloc(),
                  ),
                );
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
