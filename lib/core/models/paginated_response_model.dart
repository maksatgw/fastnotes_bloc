import 'package:json_annotation/json_annotation.dart';

part 'paginated_response_model.g.dart';

// Generic bir model.
// T tipi, sayfalanmış olarak gelen modelin içindeki List<T> tipini belirtir.
// Bu sayede, farklı modeller için aynı modeli kullanabiliriz.
// Örneğin, NoteModel için kullanılabilir.

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponseModel<T> {
  final int pageNumber;
  final int pageSize;
  final bool hasNext;
  final bool hasPrevious;
  final List<T> value;

  PaginatedResponseModel({
    required this.pageNumber,
    required this.pageSize,
    required this.hasNext,
    required this.hasPrevious,
    required this.value,
  });

  // FromJson fonksiyonu, json'dan modeli oluşturur.
  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    // fromJsonT fonksiyonu T generic tipi için, json'dan modeli oluşturur.
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseModelFromJson(json, fromJsonT);
}
