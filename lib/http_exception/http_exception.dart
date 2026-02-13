class HttpException implements Exception {
  final int statusCode;
  final String msg;

  HttpException({required this.msg, required this.statusCode});

  @override
  String toString() {
    return msg;
  }
}
