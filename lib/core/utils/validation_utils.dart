import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';

class ValidationUtils {
  static Either<Failure, String> validateRequiredField(
    String? value,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return Left(ValidationFailure(message: '$fieldName boş olamaz'));
    }
    return Right(value);
  }

  static Either<Failure, String> validateMinLength(
    String value,
    int minLength,
    String fieldName,
  ) {
    if (value.length < minLength) {
      return Left(
        ValidationFailure(
          message: '$fieldName en az $minLength karakter olmalı',
        ),
      );
    }
    return Right(value);
  }

  static Either<Failure, String> validateMaxLength(
    String value,
    int maxLength,
    String fieldName,
  ) {
    if (value.length > maxLength) {
      return Left(
        ValidationFailure(
          message: '$fieldName en fazla $maxLength karakter olabilir',
        ),
      );
    }
    return Right(value);
  }

  static Either<Failure, String> validateTextField(
    String? value,
    String fieldName, {
    int? minLength,
    int? maxLength,
  }) {
    return validateRequiredField(value, fieldName)
        .flatMap((validValue) {
          if (minLength != null) {
            return validateMinLength(validValue, minLength, fieldName);
          }
          return Right(validValue);
        })
        .flatMap((validValue) {
          if (maxLength != null) {
            return validateMaxLength(validValue, maxLength, fieldName);
          }
          return Right(validValue);
        });
  }
}
