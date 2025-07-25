// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_freezed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteDataModel {

@JsonKey(includeIfNull: false) int? get id;@JsonKey(includeIfNull: false) String? get title;@JsonKey(includeIfNull: false) String? get content;@JsonKey(includeIfNull: false) DateTime? get createdAt;@JsonKey(includeIfNull: false) DateTime? get updatedAt;@JsonKey(includeIfNull: false) String? get userId;
/// Create a copy of NoteDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteDataModelCopyWith<NoteDataModel> get copyWith => _$NoteDataModelCopyWithImpl<NoteDataModel>(this as NoteDataModel, _$identity);

  /// Serializes this NoteDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteDataModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,createdAt,updatedAt,userId);

@override
String toString() {
  return 'NoteDataModel(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $NoteDataModelCopyWith<$Res>  {
  factory $NoteDataModelCopyWith(NoteDataModel value, $Res Function(NoteDataModel) _then) = _$NoteDataModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) int? id,@JsonKey(includeIfNull: false) String? title,@JsonKey(includeIfNull: false) String? content,@JsonKey(includeIfNull: false) DateTime? createdAt,@JsonKey(includeIfNull: false) DateTime? updatedAt,@JsonKey(includeIfNull: false) String? userId
});




}
/// @nodoc
class _$NoteDataModelCopyWithImpl<$Res>
    implements $NoteDataModelCopyWith<$Res> {
  _$NoteDataModelCopyWithImpl(this._self, this._then);

  final NoteDataModel _self;
  final $Res Function(NoteDataModel) _then;

/// Create a copy of NoteDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? content = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? userId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteDataModel].
extension NoteDataModelPatterns on NoteDataModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteDataModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteDataModel value)  $default,){
final _that = this;
switch (_that) {
case _NoteDataModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoteDataModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? id, @JsonKey(includeIfNull: false)  String? title, @JsonKey(includeIfNull: false)  String? content, @JsonKey(includeIfNull: false)  DateTime? createdAt, @JsonKey(includeIfNull: false)  DateTime? updatedAt, @JsonKey(includeIfNull: false)  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteDataModel() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? id, @JsonKey(includeIfNull: false)  String? title, @JsonKey(includeIfNull: false)  String? content, @JsonKey(includeIfNull: false)  DateTime? createdAt, @JsonKey(includeIfNull: false)  DateTime? updatedAt, @JsonKey(includeIfNull: false)  String? userId)  $default,) {final _that = this;
switch (_that) {
case _NoteDataModel():
return $default(_that.id,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.userId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  int? id, @JsonKey(includeIfNull: false)  String? title, @JsonKey(includeIfNull: false)  String? content, @JsonKey(includeIfNull: false)  DateTime? createdAt, @JsonKey(includeIfNull: false)  DateTime? updatedAt, @JsonKey(includeIfNull: false)  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _NoteDataModel() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoteDataModel implements NoteDataModel {
  const _NoteDataModel({@JsonKey(includeIfNull: false) this.id, @JsonKey(includeIfNull: false) this.title, @JsonKey(includeIfNull: false) this.content, @JsonKey(includeIfNull: false) this.createdAt, @JsonKey(includeIfNull: false) this.updatedAt, @JsonKey(includeIfNull: false) this.userId});
  factory _NoteDataModel.fromJson(Map<String, dynamic> json) => _$NoteDataModelFromJson(json);

@override@JsonKey(includeIfNull: false) final  int? id;
@override@JsonKey(includeIfNull: false) final  String? title;
@override@JsonKey(includeIfNull: false) final  String? content;
@override@JsonKey(includeIfNull: false) final  DateTime? createdAt;
@override@JsonKey(includeIfNull: false) final  DateTime? updatedAt;
@override@JsonKey(includeIfNull: false) final  String? userId;

/// Create a copy of NoteDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteDataModelCopyWith<_NoteDataModel> get copyWith => __$NoteDataModelCopyWithImpl<_NoteDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteDataModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,createdAt,updatedAt,userId);

@override
String toString() {
  return 'NoteDataModel(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$NoteDataModelCopyWith<$Res> implements $NoteDataModelCopyWith<$Res> {
  factory _$NoteDataModelCopyWith(_NoteDataModel value, $Res Function(_NoteDataModel) _then) = __$NoteDataModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) int? id,@JsonKey(includeIfNull: false) String? title,@JsonKey(includeIfNull: false) String? content,@JsonKey(includeIfNull: false) DateTime? createdAt,@JsonKey(includeIfNull: false) DateTime? updatedAt,@JsonKey(includeIfNull: false) String? userId
});




}
/// @nodoc
class __$NoteDataModelCopyWithImpl<$Res>
    implements _$NoteDataModelCopyWith<$Res> {
  __$NoteDataModelCopyWithImpl(this._self, this._then);

  final _NoteDataModel _self;
  final $Res Function(_NoteDataModel) _then;

/// Create a copy of NoteDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? content = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? userId = freezed,}) {
  return _then(_NoteDataModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
