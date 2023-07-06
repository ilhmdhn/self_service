import 'package:flutter/widgets.dart';
import '../../util/order_args.dart';

class RoomDetailPage extends StatefulWidget {
  const RoomDetailPage({super.key});
  static const nameRoute = '/room-detail-page';

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  @override
  Widget build(BuildContext context) {
    final orderArgs = ModalRoute.of(context)!.settings.arguments as OrderArgs;
    print(
        "room category: ${orderArgs.roomCategory} room code: ${orderArgs.roomCode}");
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(
          context,
          orderArgs
        );
        return false;
      },
      child: const Stack(
        children: [],
      ),
    );
  }
}
