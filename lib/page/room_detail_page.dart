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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<RoomDetailCubit, RoomDetailResult>(
              bloc: roomDetailCubit,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: state.data?.roomGallery?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'http://192.168.1.248:3001/image-room?name_file=${state.data?.roomGallery?[index].imageUrl.toString()}',
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Text('${state.data?.roomGallery?[0].imageUrl}'),
                  ],
                );
              })
        ],
      ),
    );
  }
}
