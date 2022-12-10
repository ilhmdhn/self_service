import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:self_service/data/model/room_category.dart';
import '../data/api/api_request.dart';

class RoomCategoryPage extends StatelessWidget {
  RoomCategoryPage({super.key});

  RoomCategoryCubit roomCategoryCubit = RoomCategoryCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        StreamBuilder(
            stream: roomCategoryCubit.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return (Text(
                    snapshot.data!.category![1].roomCategoryName.toString()));
              } else {
                return (Text(snapshot.data!.state.toString()));
              }
            }),
        ElevatedButton(
            onPressed: () async {
              final response = await ApiService().getRoomCategory();
              roomCategoryCubit.getData(response);
            },
            child: Text('test api')),
        // ListView()
      ]),
    );
  }
}

class RoomCategoryCubit extends Cubit<RoomCategoryResult> {
  RoomCategoryCubit()
      : super(RoomCategoryResult(
            state: false, message: '', category: List.empty()));
  void getData(data) {
    emit(data);
  }
}
