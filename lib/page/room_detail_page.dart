import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/room_detail_bloc.dart';
import 'package:self_service/data/model/room_detail_model.dart';

class RoomDetailPage extends StatelessWidget {
  RoomDetailPage({super.key});

  final RoomDetailCubit roomDetailCubit = RoomDetailCubit();

  @override
  Widget build(BuildContext context) {
    roomDetailCubit.getData('R05');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<RoomDetailCubit, RoomDetailResult>(
              bloc: roomDetailCubit,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('test ${state.data?.roomDetail?.roomName}'),
                    Text('test ${state.data?.roomGallery?[0].imageUrl}'),
                  ],
                );
              })
        ],
      ),
    );
  }
}
