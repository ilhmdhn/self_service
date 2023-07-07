import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:self_service/page/room_detail_page/room_detail_bloc.dart';
import 'package:self_service/page/style/color_style.dart';
import '../../util/order_args.dart';

class RoomDetailPage extends StatefulWidget {
  const RoomDetailPage({super.key});
  static const nameRoute = '/room-detail-page';
  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  final RoomDetailCubit roomDetailCubit = RoomDetailCubit();

  @override
  Widget build(BuildContext context) {
    final orderArgs = ModalRoute.of(context)!.settings.arguments as OrderArgs;
    roomDetailCubit.setData(orderArgs.roomCategory, orderArgs.roomCode);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, orderArgs);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Container(color: Colors.blue)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColorStyle.lightBlue(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0), // Sudut kiri atas
                    topRight: Radius.circular(40.0), // Sudut kanan atas
                  ),
                ),
                // Container bawah bagian bawah
              ),
            ),
          ],
        ),
      ),
    );
  }
}
