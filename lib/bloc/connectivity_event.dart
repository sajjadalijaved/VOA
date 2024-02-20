part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}
class ConnectEvent extends ConnectivityEvent {
  final ConnectivityResult result;
  ConnectEvent(this.result);
}

class DisConnectEvent extends ConnectivityEvent {
  final ConnectivityResult result;
  DisConnectEvent(this.result);
}