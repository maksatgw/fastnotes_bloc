// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponseModel<T> _$PaginatedResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginatedResponseModel<T>(
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  hasNext: json['hasNext'] as bool,
  hasPrevious: json['hasPrevious'] as bool,
  value: (json['value'] as List<dynamic>).map(fromJsonT).toList(),
);

Map<String, dynamic> _$PaginatedResponseModelToJson<T>(
  PaginatedResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
  'hasNext': instance.hasNext,
  'hasPrevious': instance.hasPrevious,
  'value': instance.value.map(toJsonT).toList(),
};
