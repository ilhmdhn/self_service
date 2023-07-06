import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/room_list_model.dart';
import '../../data/api/api_request.dart';

class RoomListCubit extends Cubit<RoomListResult> {
  RoomListCubit() : super(RoomListResult());

  void getData(roomCategory) async {
    emit(await ApiService().getRoomList(roomCategory));
  }
}
