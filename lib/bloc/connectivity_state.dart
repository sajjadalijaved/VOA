part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}


class ConnectedState extends ConnectivityState {
  final ConnectivityResult result;
  ConnectedState(this.result);
}

class DisConnectedState extends ConnectivityState {
  final ConnectivityResult result;
  DisConnectedState(this.result);
}
