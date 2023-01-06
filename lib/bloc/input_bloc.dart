import 'package:flutter_bloc/flutter_bloc.dart';

class InputCubit extends Cubit<String> {
  String init;
  InputCubit({this.init = ''}) : super(init);

  void getData(init) => emit(init);
}