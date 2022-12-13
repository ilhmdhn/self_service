import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/room_list_bloc.dart';
import 'package:self_service/data/model/room_list_model.dart';

class RoomListPage extends StatelessWidget {
  RoomListPage({super.key});

  final RoomListCubit roomListCubit = RoomListCubit();

  @override
  Widget build(BuildContext context) {
    final roomCategoryArgs = ModalRoute.of(context)!.settings.arguments;
    roomListCubit.getData(roomCategoryArgs);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<RoomListCubit, RoomListResult>(
              bloc: roomListCubit,
              builder: (context, state) {
                return Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 5,
                        children: List.generate(state.room.length, (index) {
                          print(
                              'get img http://192.168.1.248:3001/image-room?name_file=${state.room[index].roomImage.toString()}');
                          return InkWell(
                            onTap: () {},
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'http://192.168.1.248:3001/image-room?name_file=${state.room[index].roomImage.toString()}',
                                    width: 230,
                                    height: 230,
                                  ),
                                  Text(state.room[index].roomName.toString())
                                ]),
                          );
                        })));
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/splash', (Route<dynamic> route) => false);
                  },
                  child: const Text('Batal')),
            ],
          )
        ],
      ),
    );
  }
}
