class FirstSignInException implements Exception {
  FirstSignInException({
    this.message,
  });
  final String? message;


  @override
  String toString() => 'First Sign In: $message';
}

class pickException implements Exception {
  pickException({
    this.message,
  });
  final String? message;


  @override
  String toString() => 'Pick error: $message';
}

class uploadException implements Exception {
  uploadException({
    this.message,
  });
  final String? message;


  @override
  String toString() => 'Pick error: $message';
}