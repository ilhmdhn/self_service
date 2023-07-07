import 'package:flutter_bloc/flutter_bloc.dart';

class InputCubit extends Cubit<String> {
  String init;
  InputCubit({this.init = ''}) : super(init);

  void getData(init) => emit(init);
}

class InputIntCubit extends Cubit<int?> {
  int? num;
  InputIntCubit({this.num}) : super(null);

  void setData(init) => emit(init);
}

class InputArrayCubit<T> extends Cubit<List<T>?> {
  List<T>? data;

  InputArrayCubit({this.data}) : super(null);

  void setData(List<T> initData) => emit(initData);
}