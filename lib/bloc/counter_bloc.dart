import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  int init;

  CounterCubit({this.init = 0}) : super(init);

  void increment() => emit(state + 1);
  void decrement() {
    if (state > 0) {
      return emit(state - 1);
    } else {
      return emit(0);
    }
  }

  void reset() => emit(1);
}
