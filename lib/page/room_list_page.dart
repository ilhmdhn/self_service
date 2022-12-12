import 'package:flutter/material.dart';
import 'package:self_service/bloc/room_list_bloc.dart';

class RoomListPage extends StatefulWidget {
  final String roomCategory;
  const RoomListPage({super.key, required this.roomCategory});

  @override
  State<RoomListPage> createState() => _RoomListPageState(roomCategory);
}

class _RoomListPageState extends State<RoomListPage> {
  final String roomCategoryArgs;
  _RoomListPageState(this.roomCategoryArgs);
  RoomListCubit roomListCubit = RoomListCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room List'),
      ),
    );
  }

  void getListRoom() {
    roomListCubit.getData(roomCategoryArgs.toString());
  }
}
