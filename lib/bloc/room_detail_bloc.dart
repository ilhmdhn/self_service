import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/model/room_detail_model.dart';

import '../data/api/api_request.dart';

class RoomDetailCubit extends Cubit<RoomDetailResult> {
  RoomDetailCubit(): super(RoomDetailResult());

  void getData(roomCode) async {
    final response = await ApiService().getRoomDetail(roomCode);
    emit(response);
  }
}