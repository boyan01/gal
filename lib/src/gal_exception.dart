class GalException implements Exception {
  GalException({
    required this.type,
    required this.error,
    required this.stackTrace,
  });
  final GalExceptionType type;
  final Object? error;
  final StackTrace stackTrace;

  factory GalException.fromCode({
    required String code,
    required Object? error,
    required StackTrace stackTrace,
  }) {
    final type = GalExceptionType.values.firstWhere(
      (type) => type.code == code,
      orElse: () => GalExceptionType.unexpected,
    );
    return GalException(type: type, error: error, stackTrace: stackTrace);
  }
  @override
  String toString() => type.message;
}

enum GalExceptionType {

  /// When Has no permission to access gallery app.
  accessDenied,

  /// When Insufficient device storage.
  notEnoughSpace,

  /// When trying to save a file in an unsupported format.
  /// For details please see
  /// https://github.com/natsuk4ze/gal/wiki/Formats
  notSupportedFormat,

  /// When an error occurs with unexpected.
  unexpected,

  /// When an error occurs under iOS15.
  /// Under iOS 15, it is not possible to get details of errors on saving.
  notHandle;

  String get code => switch (this) {
        accessDenied => 'ACCESS_DENIED',
        notEnoughSpace => 'NOT_ENOUGH_SPACE',
        notSupportedFormat => 'NOT_SUPPORTED_FORMAT',
        unexpected => 'UNEXPECTED',
        notHandle => 'NOT_HANDLE',
      };

  String get message => switch (this) {
        accessDenied => 'You do not have permission to access the gallery app.',
        notEnoughSpace => 'Not enough space for storage.',
        notSupportedFormat => 'Unsupported file formats.',
        unexpected => 'An unexpected error has occurred.',
        notHandle => 'An unexpected error has occurred.',
      };
}
