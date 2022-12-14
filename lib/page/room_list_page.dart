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
      appBar: AppBar(
          automaticallyImplyLeading: false, title: Text('$roomCategoryArgs')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<RoomListCubit, RoomListResult>(
              bloc: roomListCubit,
              builder: (context, state) {
                return Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        childAspectRatio: 4 / 3,
                        children: List.generate(state.room!.length, (index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/room-detail');
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black54, width: 0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            'http://192.168.1.248:3001/image-room?name_file=${state.room![index].roomImage.toString()}',
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Room Name: '),
                                          Text(state.room![index].roomName
                                              .toString())
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Room Capacity: '),
                                          Text(
                                              '${state.room![index].roomCapacity.toString()} PAX')
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Room Ready: '),
                                          Text(state.room![index].roomIsReady
                                              .toString())
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          );
                        })));
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/splash', (Route<dynamic> route) => false);
                  },
                  child: const Text('Batal')),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.lime.shade800),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali')),
            ],
          )
        ],
      ),
    );
  }
}
