sealed class NetworkResult<T> {
  const NetworkResult();
}
class NetworkSuccess<T> extends NetworkResult<T> {
  final T data;
  const NetworkSuccess(this.data);
}
class NetworkFailure<T> extends NetworkResult<T> {
  final String errorMessage;
  const NetworkFailure(this.errorMessage);
}