import 'status.dart';

class ApiResponse<T> {
  Status? status;
  String? message;
  T? data;

  ApiResponse(this.status, this.message, this.data);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.error(this.message) : status = Status.ERROR;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;
}
