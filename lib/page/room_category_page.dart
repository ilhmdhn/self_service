import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/model/room_category_model.dart';
import '../bloc/room_category_bloc.dart';

class RoomCategoryPage extends StatefulWidget {
  const RoomCategoryPage({super.key});

  @override
  State<RoomCategoryPage> createState() => _RoomCategoryPageState();
}

class _RoomCategoryPageState extends State<RoomCategoryPage> {
  RoomCategoryCubit roomCategoryCubit = RoomCategoryCubit();

  @override
  void initState() {
    super.initState();
    getCategoryRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: BlocBuilder<RoomCategoryCubit, RoomCategoryResult>(
              bloc: roomCategoryCubit,
              builder: (context, state) {
                return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 5,
                    children: List.generate(state.category.length, (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/room-list',
                              arguments:
                                  state.category[index].roomCategoryCode);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'http://192.168.1.248:3001/image-room-category?name_file=${state.category[index].roomCategoryImage}',
                                width: 230,
                                height: 230),
                            Text(
                                'Nama Kategory: ${state.category[index].roomCategoryName}')
                          ],
                        ),
                      );
                    }));
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      ]),
    );
  }

  void getCategoryRoom() {
    roomCategoryCubit.getData();
  }
}
