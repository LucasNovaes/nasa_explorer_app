import 'failure_type.dart';

class Failure {
  final FailureType type;
  final String message;
  final Object? exception;

  const Failure(this.message,
      {this.type = FailureType.unexpected, this.exception});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure &&
        other.type == type &&
        other.message == message &&
        other.exception == exception;
  }

  @override
  int get hashCode => type.hashCode ^ message.hashCode;
}
