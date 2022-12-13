import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/room_category_model.dart';
import '../data/api/api_request.dart';

class RoomCategoryCubit extends Cubit<RoomCategoryResult> {
  RoomCategoryCubit(): super(RoomCategoryResult(state: false, message: '', category: List.empty()));

  void getData() async{
    final response = await ApiService().getRoomCategory();
    emit(response);
  }
}

class RoomCategoryArgsCubit extends Cubit<String> {
  RoomCategoryArgsCubit(): super('');

  void getData(data) async{
    emit(data);
  }
}