import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/image_url_bloc.dart';
import 'package:self_service/data/model/room_category_model.dart';
import '../bloc/room_category_bloc.dart';

class RoomCategoryPage extends StatelessWidget {
  RoomCategoryPage({super.key});

  final RoomCategoryCubit roomCategoryCubit = RoomCategoryCubit();
  final ImageUrlCubit imageUrlCubit = ImageUrlCubit();

  @override
  Widget build(BuildContext context) {
    roomCategoryCubit.getData();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Category Room'),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: BlocBuilder<RoomCategoryCubit, RoomCategoryResult>(
              bloc: roomCategoryCubit,
              builder: (context, roomCategoryState) {
                if (roomCategoryState.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 5,
                      childAspectRatio: 4 / 3,
                      children: List.generate(
                          roomCategoryState.category!.length, (index) {
                        imageUrlCubit.getImageRoomCategory();
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/room-list',
                                arguments: roomCategoryState
                                    .category![index].roomCategoryCode);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black54, width: 0.3),
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  child: BlocBuilder<ImageUrlCubit, String>(
                                    bloc: imageUrlCubit,
                                    builder: (context, stateImage) {
                                      String imageUrl = stateImage +
                                          roomCategoryState.category![index]
                                              .roomCategoryImage
                                              .toString();
                                      if (stateImage != '') {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(imageUrl),
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Text(
                                    '${roomCategoryState.category![index].roomCategoryName}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 19),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.red),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/splash', (Route<dynamic> route) => false);
                  },
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.lime.shade800),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
        )
      ]),
    );
  }
}
