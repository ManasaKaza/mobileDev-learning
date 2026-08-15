sealed class OperationResult<T> {
  const OperationResult();
}

final class OperationSuccess<T> extends OperationResult<T> {
  final T data;

  const OperationSuccess(this.data);
}

final class OperationFailure<T> extends OperationResult<T> {
  final String message;

  const OperationFailure(this.message);
}
