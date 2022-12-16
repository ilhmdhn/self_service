import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';

import '../data/api/api_request.dart';

class RoomDetailCubit extends Cubit<RoomDetailResult> {
  RoomDetailCubit() : super(RoomDetailResult());

  void getData(roomCode) async {
    final response = await ApiService().getRoomDetail(roomCode);
    emit(response);
  }
}

class LoadingIndicatorState extends Cubit<LoadingIndicator> {
  LoadingIndicatorState()
      : super(const LoadingIndicator(
          indicatorType: Indicator.ballTrianglePathColored,
        ));

  Center setLoading(bool pause) {
    const loading = Center(child: LoadingIndicator(
      indicatorType: Indicator.ballTrianglePathColored,
      colors: [Colors.blue, Colors.green, Colors.yellow],
      strokeWidth: 5,
      pause: true,
    ));
    return loading;
  }
}
