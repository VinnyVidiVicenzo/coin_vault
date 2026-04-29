// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'valuation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Valuation {

 String? get id; String get itemId; DateTime get valuationDate; double get estimatedValue; String get currency; String get valueType; String get valueSource; String? get confidence; String? get notes; DateTime? get createdAt;
/// Create a copy of Valuation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValuationCopyWith<Valuation> get copyWith => _$ValuationCopyWithImpl<Valuation>(this as Valuation, _$identity);

  /// Serializes this Valuation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Valuation&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.valuationDate, valuationDate) || other.valuationDate == valuationDate)&&(identical(other.estimatedValue, estimatedValue) || other.estimatedValue == estimatedValue)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.valueType, valueType) || other.valueType == valueType)&&(identical(other.valueSource, valueSource) || other.valueSource == valueSource)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,valuationDate,estimatedValue,currency,valueType,valueSource,confidence,notes,createdAt);

@override
String toString() {
  return 'Valuation(id: $id, itemId: $itemId, valuationDate: $valuationDate, estimatedValue: $estimatedValue, currency: $currency, valueType: $valueType, valueSource: $valueSource, confidence: $confidence, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ValuationCopyWith<$Res>  {
  factory $ValuationCopyWith(Valuation value, $Res Function(Valuation) _then) = _$ValuationCopyWithImpl;
@useResult
$Res call({
 String? id, String itemId, DateTime valuationDate, double estimatedValue, String currency, String valueType, String valueSource, String? confidence, String? notes, DateTime? createdAt
});




}
/// @nodoc
class _$ValuationCopyWithImpl<$Res>
    implements $ValuationCopyWith<$Res> {
  _$ValuationCopyWithImpl(this._self, this._then);

  final Valuation _self;
  final $Res Function(Valuation) _then;

/// Create a copy of Valuation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? itemId = null,Object? valuationDate = null,Object? estimatedValue = null,Object? currency = null,Object? valueType = null,Object? valueSource = null,Object? confidence = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,valuationDate: null == valuationDate ? _self.valuationDate : valuationDate // ignore: cast_nullable_to_non_nullable
as DateTime,estimatedValue: null == estimatedValue ? _self.estimatedValue : estimatedValue // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,valueType: null == valueType ? _self.valueType : valueType // ignore: cast_nullable_to_non_nullable
as String,valueSource: null == valueSource ? _self.valueSource : valueSource // ignore: cast_nullable_to_non_nullable
as String,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Valuation].
extension ValuationPatterns on Valuation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Valuation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Valuation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Valuation value)  $default,){
final _that = this;
switch (_that) {
case _Valuation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Valuation value)?  $default,){
final _that = this;
switch (_that) {
case _Valuation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String itemId,  DateTime valuationDate,  double estimatedValue,  String currency,  String valueType,  String valueSource,  String? confidence,  String? notes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Valuation() when $default != null:
return $default(_that.id,_that.itemId,_that.valuationDate,_that.estimatedValue,_that.currency,_that.valueType,_that.valueSource,_that.confidence,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String itemId,  DateTime valuationDate,  double estimatedValue,  String currency,  String valueType,  String valueSource,  String? confidence,  String? notes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Valuation():
return $default(_that.id,_that.itemId,_that.valuationDate,_that.estimatedValue,_that.currency,_that.valueType,_that.valueSource,_that.confidence,_that.notes,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String itemId,  DateTime valuationDate,  double estimatedValue,  String currency,  String valueType,  String valueSource,  String? confidence,  String? notes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Valuation() when $default != null:
return $default(_that.id,_that.itemId,_that.valuationDate,_that.estimatedValue,_that.currency,_that.valueType,_that.valueSource,_that.confidence,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Valuation implements Valuation {
  const _Valuation({this.id, required this.itemId, required this.valuationDate, required this.estimatedValue, this.currency = 'USD', required this.valueType, required this.valueSource, this.confidence, this.notes, this.createdAt});
  factory _Valuation.fromJson(Map<String, dynamic> json) => _$ValuationFromJson(json);

@override final  String? id;
@override final  String itemId;
@override final  DateTime valuationDate;
@override final  double estimatedValue;
@override@JsonKey() final  String currency;
@override final  String valueType;
@override final  String valueSource;
@override final  String? confidence;
@override final  String? notes;
@override final  DateTime? createdAt;

/// Create a copy of Valuation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValuationCopyWith<_Valuation> get copyWith => __$ValuationCopyWithImpl<_Valuation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ValuationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Valuation&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.valuationDate, valuationDate) || other.valuationDate == valuationDate)&&(identical(other.estimatedValue, estimatedValue) || other.estimatedValue == estimatedValue)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.valueType, valueType) || other.valueType == valueType)&&(identical(other.valueSource, valueSource) || other.valueSource == valueSource)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,valuationDate,estimatedValue,currency,valueType,valueSource,confidence,notes,createdAt);

@override
String toString() {
  return 'Valuation(id: $id, itemId: $itemId, valuationDate: $valuationDate, estimatedValue: $estimatedValue, currency: $currency, valueType: $valueType, valueSource: $valueSource, confidence: $confidence, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ValuationCopyWith<$Res> implements $ValuationCopyWith<$Res> {
  factory _$ValuationCopyWith(_Valuation value, $Res Function(_Valuation) _then) = __$ValuationCopyWithImpl;
@override @useResult
$Res call({
 String? id, String itemId, DateTime valuationDate, double estimatedValue, String currency, String valueType, String valueSource, String? confidence, String? notes, DateTime? createdAt
});




}
/// @nodoc
class __$ValuationCopyWithImpl<$Res>
    implements _$ValuationCopyWith<$Res> {
  __$ValuationCopyWithImpl(this._self, this._then);

  final _Valuation _self;
  final $Res Function(_Valuation) _then;

/// Create a copy of Valuation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? itemId = null,Object? valuationDate = null,Object? estimatedValue = null,Object? currency = null,Object? valueType = null,Object? valueSource = null,Object? confidence = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_Valuation(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,valuationDate: null == valuationDate ? _self.valuationDate : valuationDate // ignore: cast_nullable_to_non_nullable
as DateTime,estimatedValue: null == estimatedValue ? _self.estimatedValue : estimatedValue // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,valueType: null == valueType ? _self.valueType : valueType // ignore: cast_nullable_to_non_nullable
as String,valueSource: null == valueSource ? _self.valueSource : valueSource // ignore: cast_nullable_to_non_nullable
as String,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
