// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ebay_listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EbayListing {

 String? get id; String get itemId; String? get listingUrl; String? get ebayItemNumber; String get listingStatus; double? get listPrice; double? get bestOfferMin; double? get soldPrice; DateTime? get soldDate; String? get buyerUsername; double? get shippingCharged; double? get ebayFinalValueFee; double? get ebayAdFee; double? get paypalFee; double? get otherFees; double? get netProceeds; DateTime? get listedDate; DateTime? get endedDate; String? get notes; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of EbayListing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EbayListingCopyWith<EbayListing> get copyWith => _$EbayListingCopyWithImpl<EbayListing>(this as EbayListing, _$identity);

  /// Serializes this EbayListing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EbayListing&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.listingUrl, listingUrl) || other.listingUrl == listingUrl)&&(identical(other.ebayItemNumber, ebayItemNumber) || other.ebayItemNumber == ebayItemNumber)&&(identical(other.listingStatus, listingStatus) || other.listingStatus == listingStatus)&&(identical(other.listPrice, listPrice) || other.listPrice == listPrice)&&(identical(other.bestOfferMin, bestOfferMin) || other.bestOfferMin == bestOfferMin)&&(identical(other.soldPrice, soldPrice) || other.soldPrice == soldPrice)&&(identical(other.soldDate, soldDate) || other.soldDate == soldDate)&&(identical(other.buyerUsername, buyerUsername) || other.buyerUsername == buyerUsername)&&(identical(other.shippingCharged, shippingCharged) || other.shippingCharged == shippingCharged)&&(identical(other.ebayFinalValueFee, ebayFinalValueFee) || other.ebayFinalValueFee == ebayFinalValueFee)&&(identical(other.ebayAdFee, ebayAdFee) || other.ebayAdFee == ebayAdFee)&&(identical(other.paypalFee, paypalFee) || other.paypalFee == paypalFee)&&(identical(other.otherFees, otherFees) || other.otherFees == otherFees)&&(identical(other.netProceeds, netProceeds) || other.netProceeds == netProceeds)&&(identical(other.listedDate, listedDate) || other.listedDate == listedDate)&&(identical(other.endedDate, endedDate) || other.endedDate == endedDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,itemId,listingUrl,ebayItemNumber,listingStatus,listPrice,bestOfferMin,soldPrice,soldDate,buyerUsername,shippingCharged,ebayFinalValueFee,ebayAdFee,paypalFee,otherFees,netProceeds,listedDate,endedDate,notes,createdAt,updatedAt]);

@override
String toString() {
  return 'EbayListing(id: $id, itemId: $itemId, listingUrl: $listingUrl, ebayItemNumber: $ebayItemNumber, listingStatus: $listingStatus, listPrice: $listPrice, bestOfferMin: $bestOfferMin, soldPrice: $soldPrice, soldDate: $soldDate, buyerUsername: $buyerUsername, shippingCharged: $shippingCharged, ebayFinalValueFee: $ebayFinalValueFee, ebayAdFee: $ebayAdFee, paypalFee: $paypalFee, otherFees: $otherFees, netProceeds: $netProceeds, listedDate: $listedDate, endedDate: $endedDate, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EbayListingCopyWith<$Res>  {
  factory $EbayListingCopyWith(EbayListing value, $Res Function(EbayListing) _then) = _$EbayListingCopyWithImpl;
@useResult
$Res call({
 String? id, String itemId, String? listingUrl, String? ebayItemNumber, String listingStatus, double? listPrice, double? bestOfferMin, double? soldPrice, DateTime? soldDate, String? buyerUsername, double? shippingCharged, double? ebayFinalValueFee, double? ebayAdFee, double? paypalFee, double? otherFees, double? netProceeds, DateTime? listedDate, DateTime? endedDate, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$EbayListingCopyWithImpl<$Res>
    implements $EbayListingCopyWith<$Res> {
  _$EbayListingCopyWithImpl(this._self, this._then);

  final EbayListing _self;
  final $Res Function(EbayListing) _then;

/// Create a copy of EbayListing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? itemId = null,Object? listingUrl = freezed,Object? ebayItemNumber = freezed,Object? listingStatus = null,Object? listPrice = freezed,Object? bestOfferMin = freezed,Object? soldPrice = freezed,Object? soldDate = freezed,Object? buyerUsername = freezed,Object? shippingCharged = freezed,Object? ebayFinalValueFee = freezed,Object? ebayAdFee = freezed,Object? paypalFee = freezed,Object? otherFees = freezed,Object? netProceeds = freezed,Object? listedDate = freezed,Object? endedDate = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,listingUrl: freezed == listingUrl ? _self.listingUrl : listingUrl // ignore: cast_nullable_to_non_nullable
as String?,ebayItemNumber: freezed == ebayItemNumber ? _self.ebayItemNumber : ebayItemNumber // ignore: cast_nullable_to_non_nullable
as String?,listingStatus: null == listingStatus ? _self.listingStatus : listingStatus // ignore: cast_nullable_to_non_nullable
as String,listPrice: freezed == listPrice ? _self.listPrice : listPrice // ignore: cast_nullable_to_non_nullable
as double?,bestOfferMin: freezed == bestOfferMin ? _self.bestOfferMin : bestOfferMin // ignore: cast_nullable_to_non_nullable
as double?,soldPrice: freezed == soldPrice ? _self.soldPrice : soldPrice // ignore: cast_nullable_to_non_nullable
as double?,soldDate: freezed == soldDate ? _self.soldDate : soldDate // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerUsername: freezed == buyerUsername ? _self.buyerUsername : buyerUsername // ignore: cast_nullable_to_non_nullable
as String?,shippingCharged: freezed == shippingCharged ? _self.shippingCharged : shippingCharged // ignore: cast_nullable_to_non_nullable
as double?,ebayFinalValueFee: freezed == ebayFinalValueFee ? _self.ebayFinalValueFee : ebayFinalValueFee // ignore: cast_nullable_to_non_nullable
as double?,ebayAdFee: freezed == ebayAdFee ? _self.ebayAdFee : ebayAdFee // ignore: cast_nullable_to_non_nullable
as double?,paypalFee: freezed == paypalFee ? _self.paypalFee : paypalFee // ignore: cast_nullable_to_non_nullable
as double?,otherFees: freezed == otherFees ? _self.otherFees : otherFees // ignore: cast_nullable_to_non_nullable
as double?,netProceeds: freezed == netProceeds ? _self.netProceeds : netProceeds // ignore: cast_nullable_to_non_nullable
as double?,listedDate: freezed == listedDate ? _self.listedDate : listedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endedDate: freezed == endedDate ? _self.endedDate : endedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EbayListing].
extension EbayListingPatterns on EbayListing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EbayListing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EbayListing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EbayListing value)  $default,){
final _that = this;
switch (_that) {
case _EbayListing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EbayListing value)?  $default,){
final _that = this;
switch (_that) {
case _EbayListing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String itemId,  String? listingUrl,  String? ebayItemNumber,  String listingStatus,  double? listPrice,  double? bestOfferMin,  double? soldPrice,  DateTime? soldDate,  String? buyerUsername,  double? shippingCharged,  double? ebayFinalValueFee,  double? ebayAdFee,  double? paypalFee,  double? otherFees,  double? netProceeds,  DateTime? listedDate,  DateTime? endedDate,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EbayListing() when $default != null:
return $default(_that.id,_that.itemId,_that.listingUrl,_that.ebayItemNumber,_that.listingStatus,_that.listPrice,_that.bestOfferMin,_that.soldPrice,_that.soldDate,_that.buyerUsername,_that.shippingCharged,_that.ebayFinalValueFee,_that.ebayAdFee,_that.paypalFee,_that.otherFees,_that.netProceeds,_that.listedDate,_that.endedDate,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String itemId,  String? listingUrl,  String? ebayItemNumber,  String listingStatus,  double? listPrice,  double? bestOfferMin,  double? soldPrice,  DateTime? soldDate,  String? buyerUsername,  double? shippingCharged,  double? ebayFinalValueFee,  double? ebayAdFee,  double? paypalFee,  double? otherFees,  double? netProceeds,  DateTime? listedDate,  DateTime? endedDate,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EbayListing():
return $default(_that.id,_that.itemId,_that.listingUrl,_that.ebayItemNumber,_that.listingStatus,_that.listPrice,_that.bestOfferMin,_that.soldPrice,_that.soldDate,_that.buyerUsername,_that.shippingCharged,_that.ebayFinalValueFee,_that.ebayAdFee,_that.paypalFee,_that.otherFees,_that.netProceeds,_that.listedDate,_that.endedDate,_that.notes,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String itemId,  String? listingUrl,  String? ebayItemNumber,  String listingStatus,  double? listPrice,  double? bestOfferMin,  double? soldPrice,  DateTime? soldDate,  String? buyerUsername,  double? shippingCharged,  double? ebayFinalValueFee,  double? ebayAdFee,  double? paypalFee,  double? otherFees,  double? netProceeds,  DateTime? listedDate,  DateTime? endedDate,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EbayListing() when $default != null:
return $default(_that.id,_that.itemId,_that.listingUrl,_that.ebayItemNumber,_that.listingStatus,_that.listPrice,_that.bestOfferMin,_that.soldPrice,_that.soldDate,_that.buyerUsername,_that.shippingCharged,_that.ebayFinalValueFee,_that.ebayAdFee,_that.paypalFee,_that.otherFees,_that.netProceeds,_that.listedDate,_that.endedDate,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EbayListing implements EbayListing {
  const _EbayListing({this.id, required this.itemId, this.listingUrl, this.ebayItemNumber, this.listingStatus = 'draft', this.listPrice, this.bestOfferMin, this.soldPrice, this.soldDate, this.buyerUsername, this.shippingCharged, this.ebayFinalValueFee, this.ebayAdFee, this.paypalFee, this.otherFees, this.netProceeds, this.listedDate, this.endedDate, this.notes, this.createdAt, this.updatedAt});
  factory _EbayListing.fromJson(Map<String, dynamic> json) => _$EbayListingFromJson(json);

@override final  String? id;
@override final  String itemId;
@override final  String? listingUrl;
@override final  String? ebayItemNumber;
@override@JsonKey() final  String listingStatus;
@override final  double? listPrice;
@override final  double? bestOfferMin;
@override final  double? soldPrice;
@override final  DateTime? soldDate;
@override final  String? buyerUsername;
@override final  double? shippingCharged;
@override final  double? ebayFinalValueFee;
@override final  double? ebayAdFee;
@override final  double? paypalFee;
@override final  double? otherFees;
@override final  double? netProceeds;
@override final  DateTime? listedDate;
@override final  DateTime? endedDate;
@override final  String? notes;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of EbayListing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EbayListingCopyWith<_EbayListing> get copyWith => __$EbayListingCopyWithImpl<_EbayListing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EbayListingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EbayListing&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.listingUrl, listingUrl) || other.listingUrl == listingUrl)&&(identical(other.ebayItemNumber, ebayItemNumber) || other.ebayItemNumber == ebayItemNumber)&&(identical(other.listingStatus, listingStatus) || other.listingStatus == listingStatus)&&(identical(other.listPrice, listPrice) || other.listPrice == listPrice)&&(identical(other.bestOfferMin, bestOfferMin) || other.bestOfferMin == bestOfferMin)&&(identical(other.soldPrice, soldPrice) || other.soldPrice == soldPrice)&&(identical(other.soldDate, soldDate) || other.soldDate == soldDate)&&(identical(other.buyerUsername, buyerUsername) || other.buyerUsername == buyerUsername)&&(identical(other.shippingCharged, shippingCharged) || other.shippingCharged == shippingCharged)&&(identical(other.ebayFinalValueFee, ebayFinalValueFee) || other.ebayFinalValueFee == ebayFinalValueFee)&&(identical(other.ebayAdFee, ebayAdFee) || other.ebayAdFee == ebayAdFee)&&(identical(other.paypalFee, paypalFee) || other.paypalFee == paypalFee)&&(identical(other.otherFees, otherFees) || other.otherFees == otherFees)&&(identical(other.netProceeds, netProceeds) || other.netProceeds == netProceeds)&&(identical(other.listedDate, listedDate) || other.listedDate == listedDate)&&(identical(other.endedDate, endedDate) || other.endedDate == endedDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,itemId,listingUrl,ebayItemNumber,listingStatus,listPrice,bestOfferMin,soldPrice,soldDate,buyerUsername,shippingCharged,ebayFinalValueFee,ebayAdFee,paypalFee,otherFees,netProceeds,listedDate,endedDate,notes,createdAt,updatedAt]);

@override
String toString() {
  return 'EbayListing(id: $id, itemId: $itemId, listingUrl: $listingUrl, ebayItemNumber: $ebayItemNumber, listingStatus: $listingStatus, listPrice: $listPrice, bestOfferMin: $bestOfferMin, soldPrice: $soldPrice, soldDate: $soldDate, buyerUsername: $buyerUsername, shippingCharged: $shippingCharged, ebayFinalValueFee: $ebayFinalValueFee, ebayAdFee: $ebayAdFee, paypalFee: $paypalFee, otherFees: $otherFees, netProceeds: $netProceeds, listedDate: $listedDate, endedDate: $endedDate, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EbayListingCopyWith<$Res> implements $EbayListingCopyWith<$Res> {
  factory _$EbayListingCopyWith(_EbayListing value, $Res Function(_EbayListing) _then) = __$EbayListingCopyWithImpl;
@override @useResult
$Res call({
 String? id, String itemId, String? listingUrl, String? ebayItemNumber, String listingStatus, double? listPrice, double? bestOfferMin, double? soldPrice, DateTime? soldDate, String? buyerUsername, double? shippingCharged, double? ebayFinalValueFee, double? ebayAdFee, double? paypalFee, double? otherFees, double? netProceeds, DateTime? listedDate, DateTime? endedDate, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$EbayListingCopyWithImpl<$Res>
    implements _$EbayListingCopyWith<$Res> {
  __$EbayListingCopyWithImpl(this._self, this._then);

  final _EbayListing _self;
  final $Res Function(_EbayListing) _then;

/// Create a copy of EbayListing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? itemId = null,Object? listingUrl = freezed,Object? ebayItemNumber = freezed,Object? listingStatus = null,Object? listPrice = freezed,Object? bestOfferMin = freezed,Object? soldPrice = freezed,Object? soldDate = freezed,Object? buyerUsername = freezed,Object? shippingCharged = freezed,Object? ebayFinalValueFee = freezed,Object? ebayAdFee = freezed,Object? paypalFee = freezed,Object? otherFees = freezed,Object? netProceeds = freezed,Object? listedDate = freezed,Object? endedDate = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_EbayListing(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,listingUrl: freezed == listingUrl ? _self.listingUrl : listingUrl // ignore: cast_nullable_to_non_nullable
as String?,ebayItemNumber: freezed == ebayItemNumber ? _self.ebayItemNumber : ebayItemNumber // ignore: cast_nullable_to_non_nullable
as String?,listingStatus: null == listingStatus ? _self.listingStatus : listingStatus // ignore: cast_nullable_to_non_nullable
as String,listPrice: freezed == listPrice ? _self.listPrice : listPrice // ignore: cast_nullable_to_non_nullable
as double?,bestOfferMin: freezed == bestOfferMin ? _self.bestOfferMin : bestOfferMin // ignore: cast_nullable_to_non_nullable
as double?,soldPrice: freezed == soldPrice ? _self.soldPrice : soldPrice // ignore: cast_nullable_to_non_nullable
as double?,soldDate: freezed == soldDate ? _self.soldDate : soldDate // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerUsername: freezed == buyerUsername ? _self.buyerUsername : buyerUsername // ignore: cast_nullable_to_non_nullable
as String?,shippingCharged: freezed == shippingCharged ? _self.shippingCharged : shippingCharged // ignore: cast_nullable_to_non_nullable
as double?,ebayFinalValueFee: freezed == ebayFinalValueFee ? _self.ebayFinalValueFee : ebayFinalValueFee // ignore: cast_nullable_to_non_nullable
as double?,ebayAdFee: freezed == ebayAdFee ? _self.ebayAdFee : ebayAdFee // ignore: cast_nullable_to_non_nullable
as double?,paypalFee: freezed == paypalFee ? _self.paypalFee : paypalFee // ignore: cast_nullable_to_non_nullable
as double?,otherFees: freezed == otherFees ? _self.otherFees : otherFees // ignore: cast_nullable_to_non_nullable
as double?,netProceeds: freezed == netProceeds ? _self.netProceeds : netProceeds // ignore: cast_nullable_to_non_nullable
as double?,listedDate: freezed == listedDate ? _self.listedDate : listedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endedDate: freezed == endedDate ? _self.endedDate : endedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
