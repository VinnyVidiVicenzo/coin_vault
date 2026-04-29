// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogReference {

 String? get id; String get itemId; String get catalogSystem; String get referenceNumber; String? get varietyName; String? get diePair; String? get attributionConfidence; String? get attributionSource; String? get notes; DateTime? get createdAt;
/// Create a copy of CatalogReference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogReferenceCopyWith<CatalogReference> get copyWith => _$CatalogReferenceCopyWithImpl<CatalogReference>(this as CatalogReference, _$identity);

  /// Serializes this CatalogReference to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogReference&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.catalogSystem, catalogSystem) || other.catalogSystem == catalogSystem)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.varietyName, varietyName) || other.varietyName == varietyName)&&(identical(other.diePair, diePair) || other.diePair == diePair)&&(identical(other.attributionConfidence, attributionConfidence) || other.attributionConfidence == attributionConfidence)&&(identical(other.attributionSource, attributionSource) || other.attributionSource == attributionSource)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,catalogSystem,referenceNumber,varietyName,diePair,attributionConfidence,attributionSource,notes,createdAt);

@override
String toString() {
  return 'CatalogReference(id: $id, itemId: $itemId, catalogSystem: $catalogSystem, referenceNumber: $referenceNumber, varietyName: $varietyName, diePair: $diePair, attributionConfidence: $attributionConfidence, attributionSource: $attributionSource, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CatalogReferenceCopyWith<$Res>  {
  factory $CatalogReferenceCopyWith(CatalogReference value, $Res Function(CatalogReference) _then) = _$CatalogReferenceCopyWithImpl;
@useResult
$Res call({
 String? id, String itemId, String catalogSystem, String referenceNumber, String? varietyName, String? diePair, String? attributionConfidence, String? attributionSource, String? notes, DateTime? createdAt
});




}
/// @nodoc
class _$CatalogReferenceCopyWithImpl<$Res>
    implements $CatalogReferenceCopyWith<$Res> {
  _$CatalogReferenceCopyWithImpl(this._self, this._then);

  final CatalogReference _self;
  final $Res Function(CatalogReference) _then;

/// Create a copy of CatalogReference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? itemId = null,Object? catalogSystem = null,Object? referenceNumber = null,Object? varietyName = freezed,Object? diePair = freezed,Object? attributionConfidence = freezed,Object? attributionSource = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,catalogSystem: null == catalogSystem ? _self.catalogSystem : catalogSystem // ignore: cast_nullable_to_non_nullable
as String,referenceNumber: null == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String,varietyName: freezed == varietyName ? _self.varietyName : varietyName // ignore: cast_nullable_to_non_nullable
as String?,diePair: freezed == diePair ? _self.diePair : diePair // ignore: cast_nullable_to_non_nullable
as String?,attributionConfidence: freezed == attributionConfidence ? _self.attributionConfidence : attributionConfidence // ignore: cast_nullable_to_non_nullable
as String?,attributionSource: freezed == attributionSource ? _self.attributionSource : attributionSource // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogReference].
extension CatalogReferencePatterns on CatalogReference {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogReference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogReference() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogReference value)  $default,){
final _that = this;
switch (_that) {
case _CatalogReference():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogReference value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogReference() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String itemId,  String catalogSystem,  String referenceNumber,  String? varietyName,  String? diePair,  String? attributionConfidence,  String? attributionSource,  String? notes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogReference() when $default != null:
return $default(_that.id,_that.itemId,_that.catalogSystem,_that.referenceNumber,_that.varietyName,_that.diePair,_that.attributionConfidence,_that.attributionSource,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String itemId,  String catalogSystem,  String referenceNumber,  String? varietyName,  String? diePair,  String? attributionConfidence,  String? attributionSource,  String? notes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CatalogReference():
return $default(_that.id,_that.itemId,_that.catalogSystem,_that.referenceNumber,_that.varietyName,_that.diePair,_that.attributionConfidence,_that.attributionSource,_that.notes,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String itemId,  String catalogSystem,  String referenceNumber,  String? varietyName,  String? diePair,  String? attributionConfidence,  String? attributionSource,  String? notes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CatalogReference() when $default != null:
return $default(_that.id,_that.itemId,_that.catalogSystem,_that.referenceNumber,_that.varietyName,_that.diePair,_that.attributionConfidence,_that.attributionSource,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogReference implements CatalogReference {
  const _CatalogReference({this.id, required this.itemId, required this.catalogSystem, required this.referenceNumber, this.varietyName, this.diePair, this.attributionConfidence, this.attributionSource, this.notes, this.createdAt});
  factory _CatalogReference.fromJson(Map<String, dynamic> json) => _$CatalogReferenceFromJson(json);

@override final  String? id;
@override final  String itemId;
@override final  String catalogSystem;
@override final  String referenceNumber;
@override final  String? varietyName;
@override final  String? diePair;
@override final  String? attributionConfidence;
@override final  String? attributionSource;
@override final  String? notes;
@override final  DateTime? createdAt;

/// Create a copy of CatalogReference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogReferenceCopyWith<_CatalogReference> get copyWith => __$CatalogReferenceCopyWithImpl<_CatalogReference>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogReferenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogReference&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.catalogSystem, catalogSystem) || other.catalogSystem == catalogSystem)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.varietyName, varietyName) || other.varietyName == varietyName)&&(identical(other.diePair, diePair) || other.diePair == diePair)&&(identical(other.attributionConfidence, attributionConfidence) || other.attributionConfidence == attributionConfidence)&&(identical(other.attributionSource, attributionSource) || other.attributionSource == attributionSource)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,catalogSystem,referenceNumber,varietyName,diePair,attributionConfidence,attributionSource,notes,createdAt);

@override
String toString() {
  return 'CatalogReference(id: $id, itemId: $itemId, catalogSystem: $catalogSystem, referenceNumber: $referenceNumber, varietyName: $varietyName, diePair: $diePair, attributionConfidence: $attributionConfidence, attributionSource: $attributionSource, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CatalogReferenceCopyWith<$Res> implements $CatalogReferenceCopyWith<$Res> {
  factory _$CatalogReferenceCopyWith(_CatalogReference value, $Res Function(_CatalogReference) _then) = __$CatalogReferenceCopyWithImpl;
@override @useResult
$Res call({
 String? id, String itemId, String catalogSystem, String referenceNumber, String? varietyName, String? diePair, String? attributionConfidence, String? attributionSource, String? notes, DateTime? createdAt
});




}
/// @nodoc
class __$CatalogReferenceCopyWithImpl<$Res>
    implements _$CatalogReferenceCopyWith<$Res> {
  __$CatalogReferenceCopyWithImpl(this._self, this._then);

  final _CatalogReference _self;
  final $Res Function(_CatalogReference) _then;

/// Create a copy of CatalogReference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? itemId = null,Object? catalogSystem = null,Object? referenceNumber = null,Object? varietyName = freezed,Object? diePair = freezed,Object? attributionConfidence = freezed,Object? attributionSource = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_CatalogReference(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,catalogSystem: null == catalogSystem ? _self.catalogSystem : catalogSystem // ignore: cast_nullable_to_non_nullable
as String,referenceNumber: null == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String,varietyName: freezed == varietyName ? _self.varietyName : varietyName // ignore: cast_nullable_to_non_nullable
as String?,diePair: freezed == diePair ? _self.diePair : diePair // ignore: cast_nullable_to_non_nullable
as String?,attributionConfidence: freezed == attributionConfidence ? _self.attributionConfidence : attributionConfidence // ignore: cast_nullable_to_non_nullable
as String?,attributionSource: freezed == attributionSource ? _self.attributionSource : attributionSource // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
