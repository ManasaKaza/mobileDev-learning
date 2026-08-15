import 'operation_result.dart';

extension OperationResultExtensions<T> on OperationResult<T> {
  bool get isSuccess {
    return this is OperationSuccess<T>;
  }

  bool get isFailure {
    return this is OperationFailure<T>;
  }

  T? get dataOrNull {
    return switch (this) {
      OperationSuccess<T>(:final data) => data,
      OperationFailure<T>() => null,
    };
  }

  String? get errorMessageOrNull {
    return switch (this) {
      OperationSuccess<T>() => null,
      OperationFailure<T>(:final message) => message,
    };
  }
}
