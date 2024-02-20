import 'dart:async';
// ignore_for_file: depend_on_referenced_packages

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'connectivity_event.dart';

part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    checkConnectivity();
    listenConnectivity();

    on<DisConnectEvent>((event, emit) {
      emit.call(DisConnectedState(event.result));
    });
    on<ConnectEvent>((event, emit) {
      emit.call(ConnectedState(event.result));
    });
  }

  bool isConnected(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.bluetooth ||
        result == ConnectivityResult.ethernet;
  }

  void checkConnectivity() {
    _connectivity.checkConnectivity().then((result) {
      if (isConnected(result)) {
        add(ConnectEvent(result));
      } else {
        add(DisConnectEvent(result));
      }
    });
  }

  void listenConnectivity() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (isConnected(result)) {
        add(ConnectEvent(result));
      } else {
        add(DisConnectEvent(result));
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
