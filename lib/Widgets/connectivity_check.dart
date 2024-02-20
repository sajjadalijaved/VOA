import 'package:flutter/material.dart';
import '../bloc/connectivity_bloc.dart';
import '../Utils/no_connection_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Screens/CallScreens/call_screen.dart';
// ignore_for_file: must_be_immutable

class CheckConnectivityCallScreen extends StatelessWidget {
  dynamic userId;
  dynamic lat;
  dynamic long;
  CheckConnectivityCallScreen({Key? key, this.userId, this.lat, this.long})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectedState) {
          return CallScreen(
            lat: lat.toString(),
            long: long.toString(),
            user_id: userId,
          );
        } else if (state is DisConnectedState) {
          return const NoConnectionPage();
        } else {
          return Container();
        }
      },
    );
  }
}
