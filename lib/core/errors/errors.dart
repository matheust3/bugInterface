class SetDataError extends Error {
  final String? message;

  SetDataError(this.message);

  String toString() {
    if (message != null) {
      return "SetData failed: ${Error.safeToString(message)}";
    }
    return "SetData failed";
  }
}

class WebAdapterError extends Error {
  final String? message;

  WebAdapterError(this.message);

  String toString() {
    if (message != null) {
      return "SetData failed: ${Error.safeToString(message)}";
    }
    return "SetData failed";
  }
}
