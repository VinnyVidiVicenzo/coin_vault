// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'acquisition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Acquisition {

 String? get id; String get itemId; DateTime? get purchaseDate; String? get sourceType; String? get sellerName; String? get sellerContact; String? get lotNumber; double? get purchasePrice; double? get buyersPremium; double? get shippingCost; double? get taxPaid; double? get otherFees; double? get totalCost; String get currency; String? get paymentMethod; String get costBasisType; String? get notes; DateTime? get createdAt;
/// Create a copy of Acquisition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AcquisitionCopyWith<Acquisition> get copyWith => _$AcquisitionCopyWithImpl<Acquisition>(this as Acquisition, _$identity);

  /// Serializes this Acquisition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Acquisition&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.sellerContact, sellerContact) || other.sellerContact == sellerContact)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.buyersPremium, buyersPremium) || other.buyersPremium == buyersPremium)&&(identical(other.shippingCost, shippingCost) || other.shippingCost == shippingCost)&&(identical(other.taxPaid, taxPaid) || other.taxPaid == taxPaid)&&(identical(other.otherFees, otherFees) || other.otherFees == otherFees)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.costBasisType, costBasisType) || other.costBasisType == costBasisType)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,purchaseDate,sourceType,sellerName,sellerContact,lotNumber,purchasePrice,buyersPremium,shippingCost,taxPaid,otherFees,totalCost,currency,paymentMethod,costBasisType,notes,createdAt);

@override
String toString() {
  return 'Acquisition(id: $id, itemId: $itemId, purchaseDate: $purchaseDate, sourceType: $sourceType, sellerName: $sellerName, sellerContact: $sellerContact, lotNumber: $lotNumber, purchasePrice: $purchasePrice, buyersPremium: $buyersPremium, shippingCost: $shippingCost, taxPaid: $taxPaid, otherFees: $otherFees, totalCost: $totalCost, currency: $currency, paymentMethod: $paymentMethod, costBasisType: $costBasisType, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AcquisitionCopyWith<$Res>  {
  factory $AcquisitionCopyWith(Acquisition value, $Res Function(Acquisition) _then) = _$AcquisitionCopyWithImpl;
@useResult
$Res call({
 String? id, String itemId, DateTime? purchaseDate, String? sourceType, String? sellerName, String? sellerContact, String? lotNumber, double? purchasePrice, double? buyersPremium, double? shippingCost, double? taxPaid, double? otherFees, double? totalCost, String currency, String? paymentMethod, String costBasisType, String? notes, DateTime? createdAt
});




}
/// @nodoc
class _$AcquisitionCopyWithImpl<$Res>
    implements $AcquisitionCopyWith<$Res> {
  _$AcquisitionCopyWithImpl(this._self, this._then);

  final Acquisition _self;
  final $Res Function(Acquisition) _then;

/// Create a copy of Acquisition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? itemId = null,Object? purchaseDate = freezed,Object? sourceType = freezed,Object? sellerName = freezed,Object? sellerContact = freezed,Object? lotNumber = freezed,Object? purchasePrice = freezed,Object? buyersPremium = freezed,Object? shippingCost = freezed,Object? taxPaid = freezed,Object? otherFees = freezed,Object? totalCost = freezed,Object? currency = null,Object? paymentMethod = freezed,Object? costBasisType = null,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,purchaseDate: freezed == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sourceType: freezed == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String?,sellerName: freezed == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String?,sellerContact: freezed == sellerContact ? _self.sellerContact : sellerContact // ignore: cast_nullable_to_non_nullable
as String?,lotNumber: freezed == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,buyersPremium: freezed == buyersPremium ? _self.buyersPremium : buyersPremium // ignore: cast_nullable_to_non_nullable
as double?,shippingCost: freezed == shippingCost ? _self.shippingCost : shippingCost // ignore: cast_nullable_to_non_nullable
as double?,taxPaid: freezed == taxPaid ? _self.taxPaid : taxPaid // ignore: cast_nullable_to_non_nullable
as double?,otherFees: freezed == otherFees ? _self.otherFees : otherFees // ignore: cast_nullable_to_non_nullable
as double?,totalCost: freezed == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,costBasisType: null == costBasisType ? _self.costBasisType : costBasisType // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Acquisition].
extension AcquisitionPatterns on Acquisition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Acquisition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Acquisition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Acquisition value)  $default,){
final _that = this;
switch (_that) {
case _Acquisition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Acquisition value)?  $default,){
final _that = this;
switch (_that) {
case _Acquisition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String itemId,  DateTime? purchaseDate,  String? sourceType,  String? sellerName,  String? sellerContact,  String? lotNumber,  double? purchasePrice,  double? buyersPremium,  double? shippingCost,  double? taxPaid,  double? otherFees,  double? totalCost,  String currency,  String? paymentMethod,  String costBasisType,  String? notes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Acquisition() when $default != null:
return $default(_that.id,_that.itemId,_that.purchaseDate,_that.sourceType,_that.sellerName,_that.sellerContact,_that.lotNumber,_that.purchasePrice,_that.buyersPremium,_that.shippingCost,_that.taxPaid,_that.otherFees,_that.totalCost,_that.currency,_that.paymentMethod,_that.costBasisType,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String itemId,  DateTime? purchaseDate,  String? sourceType,  String? sellerName,  String? sellerContact,  String? lotNumber,  double? purchasePrice,  double? buyersPremium,  double? shippingCost,  double? taxPaid,  double? otherFees,  double? totalCost,  String currency,  String? paymentMethod,  String costBasisType,  String? notes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Acquisition():
return $default(_that.id,_that.itemId,_that.purchaseDate,_that.sourceType,_that.sellerName,_that.sellerContact,_that.lotNumber,_that.purchasePrice,_that.buyersPremium,_that.shippingCost,_that.taxPaid,_that.otherFees,_that.totalCost,_that.currency,_that.paymentMethod,_that.costBasisType,_that.notes,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String itemId,  DateTime? purchaseDate,  String? sourceType,  String? sellerName,  String? sellerContact,  String? lotNumber,  double? purchasePrice,  double? buyersPremium,  double? shippingCost,  double? taxPaid,  double? otherFees,  double? totalCost,  String currency,  String? paymentMethod,  String costBasisType,  String? notes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Acquisition() when $default != null:
return $default(_that.id,_that.itemId,_that.purchaseDate,_that.sourceType,_that.sellerName,_that.sellerContact,_that.lotNumber,_that.purchasePrice,_that.buyersPremium,_that.shippingCost,_that.taxPaid,_that.otherFees,_that.totalCost,_that.currency,_that.paymentMethod,_that.costBasisType,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Acquisition implements Acquisition {
  const _Acquisition({this.id, required this.itemId, this.purchaseDate, this.sourceType, this.sellerName, this.sellerContact, this.lotNumber, this.purchasePrice, this.buyersPremium, this.shippingCost, this.taxPaid, this.otherFees, this.totalCost, this.currency = 'USD', this.paymentMethod, this.costBasisType = 'known', this.notes, this.createdAt});
  factory _Acquisition.fromJson(Map<String, dynamic> json) => _$AcquisitionFromJson(json);

@override final  String? id;
@override final  String itemId;
@override final  DateTime? purchaseDate;
@override final  String? sourceType;
@override final  String? sellerName;
@override final  String? sellerContact;
@override final  String? lotNumber;
@override final  double? purchasePrice;
@override final  double? buyersPremium;
@override final  double? shippingCost;
@override final  double? taxPaid;
@override final  double? otherFees;
@override final  double? totalCost;
@override@JsonKey() final  String currency;
@override final  String? paymentMethod;
@override@JsonKey() final  String costBasisType;
@override final  String? notes;
@override final  DateTime? createdAt;

/// Create a copy of Acquisition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcquisitionCopyWith<_Acquisition> get copyWith => __$AcquisitionCopyWithImpl<_Acquisition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AcquisitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Acquisition&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.sellerContact, sellerContact) || other.sellerContact == sellerContact)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.buyersPremium, buyersPremium) || other.buyersPremium == buyersPremium)&&(identical(other.shippingCost, shippingCost) || other.shippingCost == shippingCost)&&(identical(other.taxPaid, taxPaid) || other.taxPaid == taxPaid)&&(identical(other.otherFees, otherFees) || other.otherFees == otherFees)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.costBasisType, costBasisType) || other.costBasisType == costBasisType)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,purchaseDate,sourceType,sellerName,sellerContact,lotNumber,purchasePrice,buyersPremium,shippingCost,taxPaid,otherFees,totalCost,currency,paymentMethod,costBasisType,notes,createdAt);

@override
String toString() {
  return 'Acquisition(id: $id, itemId: $itemId, purchaseDate: $purchaseDate, sourceType: $sourceType, sellerName: $sellerName, sellerContact: $sellerContact, lotNumber: $lotNumber, purchasePrice: $purchasePrice, buyersPremium: $buyersPremium, shippingCost: $shippingCost, taxPaid: $taxPaid, otherFees: $otherFees, totalCost: $totalCost, currency: $currency, paymentMethod: $paymentMethod, costBasisType: $costBasisType, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AcquisitionCopyWith<$Res> implements $AcquisitionCopyWith<$Res> {
  factory _$AcquisitionCopyWith(_Acquisition value, $Res Function(_Acquisition) _then) = __$AcquisitionCopyWithImpl;
@override @useResult
$Res call({
 String? id, String itemId, DateTime? purchaseDate, String? sourceType, String? sellerName, String? sellerContact, String? lotNumber, double? purchasePrice, double? buyersPremium, double? shippingCost, double? taxPaid, double? otherFees, double? totalCost, String currency, String? paymentMethod, String costBasisType, String? notes, DateTime? createdAt
});




}
/// @nodoc
class __$AcquisitionCopyWithImpl<$Res>
    implements _$AcquisitionCopyWith<$Res> {
  __$AcquisitionCopyWithImpl(this._self, this._then);

  final _Acquisition _self;
  final $Res Function(_Acquisition) _then;

/// Create a copy of Acquisition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? itemId = null,Object? purchaseDate = freezed,Object? sourceType = freezed,Object? sellerName = freezed,Object? sellerContact = freezed,Object? lotNumber = freezed,Object? purchasePrice = freezed,Object? buyersPremium = freezed,Object? shippingCost = freezed,Object? taxPaid = freezed,Object? otherFees = freezed,Object? totalCost = freezed,Object? currency = null,Object? paymentMethod = freezed,Object? costBasisType = null,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_Acquisition(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,purchaseDate: freezed == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sourceType: freezed == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String?,sellerName: freezed == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String?,sellerContact: freezed == sellerContact ? _self.sellerContact : sellerContact // ignore: cast_nullable_to_non_nullable
as String?,lotNumber: freezed == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,buyersPremium: freezed == buyersPremium ? _self.buyersPremium : buyersPremium // ignore: cast_nullable_to_non_nullable
as double?,shippingCost: freezed == shippingCost ? _self.shippingCost : shippingCost // ignore: cast_nullable_to_non_nullable
as double?,taxPaid: freezed == taxPaid ? _self.taxPaid : taxPaid // ignore: cast_nullable_to_non_nullable
as double?,otherFees: freezed == otherFees ? _self.otherFees : otherFees // ignore: cast_nullable_to_non_nullable
as double?,totalCost: freezed == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,costBasisType: null == costBasisType ? _self.costBasisType : costBasisType // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
