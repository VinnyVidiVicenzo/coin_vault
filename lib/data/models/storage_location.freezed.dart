// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StorageLocation {

 String? get id; String get locationName; String? get locationType; String? get addressNotes; String? get environmentNotes; bool get isActive; DateTime? get createdAt;
/// Create a copy of StorageLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageLocationCopyWith<StorageLocation> get copyWith => _$StorageLocationCopyWithImpl<StorageLocation>(this as StorageLocation, _$identity);

  /// Serializes this StorageLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.locationType, locationType) || other.locationType == locationType)&&(identical(other.addressNotes, addressNotes) || other.addressNotes == addressNotes)&&(identical(other.environmentNotes, environmentNotes) || other.environmentNotes == environmentNotes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,locationName,locationType,addressNotes,environmentNotes,isActive,createdAt);

@override
String toString() {
  return 'StorageLocation(id: $id, locationName: $locationName, locationType: $locationType, addressNotes: $addressNotes, environmentNotes: $environmentNotes, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $StorageLocationCopyWith<$Res>  {
  factory $StorageLocationCopyWith(StorageLocation value, $Res Function(StorageLocation) _then) = _$StorageLocationCopyWithImpl;
@useResult
$Res call({
 String? id, String locationName, String? locationType, String? addressNotes, String? environmentNotes, bool isActive, DateTime? createdAt
});




}
/// @nodoc
class _$StorageLocationCopyWithImpl<$Res>
    implements $StorageLocationCopyWith<$Res> {
  _$StorageLocationCopyWithImpl(this._self, this._then);

  final StorageLocation _self;
  final $Res Function(StorageLocation) _then;

/// Create a copy of StorageLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? locationName = null,Object? locationType = freezed,Object? addressNotes = freezed,Object? environmentNotes = freezed,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,locationName: null == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String,locationType: freezed == locationType ? _self.locationType : locationType // ignore: cast_nullable_to_non_nullable
as String?,addressNotes: freezed == addressNotes ? _self.addressNotes : addressNotes // ignore: cast_nullable_to_non_nullable
as String?,environmentNotes: freezed == environmentNotes ? _self.environmentNotes : environmentNotes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StorageLocation].
extension StorageLocationPatterns on StorageLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageLocation value)  $default,){
final _that = this;
switch (_that) {
case _StorageLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageLocation value)?  $default,){
final _that = this;
switch (_that) {
case _StorageLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String locationName,  String? locationType,  String? addressNotes,  String? environmentNotes,  bool isActive,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageLocation() when $default != null:
return $default(_that.id,_that.locationName,_that.locationType,_that.addressNotes,_that.environmentNotes,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String locationName,  String? locationType,  String? addressNotes,  String? environmentNotes,  bool isActive,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _StorageLocation():
return $default(_that.id,_that.locationName,_that.locationType,_that.addressNotes,_that.environmentNotes,_that.isActive,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String locationName,  String? locationType,  String? addressNotes,  String? environmentNotes,  bool isActive,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _StorageLocation() when $default != null:
return $default(_that.id,_that.locationName,_that.locationType,_that.addressNotes,_that.environmentNotes,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorageLocation implements StorageLocation {
  const _StorageLocation({this.id, required this.locationName, this.locationType, this.addressNotes, this.environmentNotes, this.isActive = true, this.createdAt});
  factory _StorageLocation.fromJson(Map<String, dynamic> json) => _$StorageLocationFromJson(json);

@override final  String? id;
@override final  String locationName;
@override final  String? locationType;
@override final  String? addressNotes;
@override final  String? environmentNotes;
@override@JsonKey() final  bool isActive;
@override final  DateTime? createdAt;

/// Create a copy of StorageLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageLocationCopyWith<_StorageLocation> get copyWith => __$StorageLocationCopyWithImpl<_StorageLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorageLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.locationType, locationType) || other.locationType == locationType)&&(identical(other.addressNotes, addressNotes) || other.addressNotes == addressNotes)&&(identical(other.environmentNotes, environmentNotes) || other.environmentNotes == environmentNotes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,locationName,locationType,addressNotes,environmentNotes,isActive,createdAt);

@override
String toString() {
  return 'StorageLocation(id: $id, locationName: $locationName, locationType: $locationType, addressNotes: $addressNotes, environmentNotes: $environmentNotes, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$StorageLocationCopyWith<$Res> implements $StorageLocationCopyWith<$Res> {
  factory _$StorageLocationCopyWith(_StorageLocation value, $Res Function(_StorageLocation) _then) = __$StorageLocationCopyWithImpl;
@override @useResult
$Res call({
 String? id, String locationName, String? locationType, String? addressNotes, String? environmentNotes, bool isActive, DateTime? createdAt
});




}
/// @nodoc
class __$StorageLocationCopyWithImpl<$Res>
    implements _$StorageLocationCopyWith<$Res> {
  __$StorageLocationCopyWithImpl(this._self, this._then);

  final _StorageLocation _self;
  final $Res Function(_StorageLocation) _then;

/// Create a copy of StorageLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? locationName = null,Object? locationType = freezed,Object? addressNotes = freezed,Object? environmentNotes = freezed,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_StorageLocation(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,locationName: null == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String,locationType: freezed == locationType ? _self.locationType : locationType // ignore: cast_nullable_to_non_nullable
as String?,addressNotes: freezed == addressNotes ? _self.addressNotes : addressNotes // ignore: cast_nullable_to_non_nullable
as String?,environmentNotes: freezed == environmentNotes ? _self.environmentNotes : environmentNotes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ItemStorage {

 String? get id; String get itemId; String get storageLocationId; String? get containerType; String? get containerLabel; String? get slotEnvelopeNumber; String? get holderType; String? get environmentNotes; DateTime? get lastVerifiedDate; String? get notes; DateTime? get createdAt; DateTime? get updatedAt; StorageLocation? get location;
/// Create a copy of ItemStorage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemStorageCopyWith<ItemStorage> get copyWith => _$ItemStorageCopyWithImpl<ItemStorage>(this as ItemStorage, _$identity);

  /// Serializes this ItemStorage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemStorage&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.storageLocationId, storageLocationId) || other.storageLocationId == storageLocationId)&&(identical(other.containerType, containerType) || other.containerType == containerType)&&(identical(other.containerLabel, containerLabel) || other.containerLabel == containerLabel)&&(identical(other.slotEnvelopeNumber, slotEnvelopeNumber) || other.slotEnvelopeNumber == slotEnvelopeNumber)&&(identical(other.holderType, holderType) || other.holderType == holderType)&&(identical(other.environmentNotes, environmentNotes) || other.environmentNotes == environmentNotes)&&(identical(other.lastVerifiedDate, lastVerifiedDate) || other.lastVerifiedDate == lastVerifiedDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,storageLocationId,containerType,containerLabel,slotEnvelopeNumber,holderType,environmentNotes,lastVerifiedDate,notes,createdAt,updatedAt,location);

@override
String toString() {
  return 'ItemStorage(id: $id, itemId: $itemId, storageLocationId: $storageLocationId, containerType: $containerType, containerLabel: $containerLabel, slotEnvelopeNumber: $slotEnvelopeNumber, holderType: $holderType, environmentNotes: $environmentNotes, lastVerifiedDate: $lastVerifiedDate, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, location: $location)';
}


}

/// @nodoc
abstract mixin class $ItemStorageCopyWith<$Res>  {
  factory $ItemStorageCopyWith(ItemStorage value, $Res Function(ItemStorage) _then) = _$ItemStorageCopyWithImpl;
@useResult
$Res call({
 String? id, String itemId, String storageLocationId, String? containerType, String? containerLabel, String? slotEnvelopeNumber, String? holderType, String? environmentNotes, DateTime? lastVerifiedDate, String? notes, DateTime? createdAt, DateTime? updatedAt, StorageLocation? location
});


$StorageLocationCopyWith<$Res>? get location;

}
/// @nodoc
class _$ItemStorageCopyWithImpl<$Res>
    implements $ItemStorageCopyWith<$Res> {
  _$ItemStorageCopyWithImpl(this._self, this._then);

  final ItemStorage _self;
  final $Res Function(ItemStorage) _then;

/// Create a copy of ItemStorage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? itemId = null,Object? storageLocationId = null,Object? containerType = freezed,Object? containerLabel = freezed,Object? slotEnvelopeNumber = freezed,Object? holderType = freezed,Object? environmentNotes = freezed,Object? lastVerifiedDate = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,storageLocationId: null == storageLocationId ? _self.storageLocationId : storageLocationId // ignore: cast_nullable_to_non_nullable
as String,containerType: freezed == containerType ? _self.containerType : containerType // ignore: cast_nullable_to_non_nullable
as String?,containerLabel: freezed == containerLabel ? _self.containerLabel : containerLabel // ignore: cast_nullable_to_non_nullable
as String?,slotEnvelopeNumber: freezed == slotEnvelopeNumber ? _self.slotEnvelopeNumber : slotEnvelopeNumber // ignore: cast_nullable_to_non_nullable
as String?,holderType: freezed == holderType ? _self.holderType : holderType // ignore: cast_nullable_to_non_nullable
as String?,environmentNotes: freezed == environmentNotes ? _self.environmentNotes : environmentNotes // ignore: cast_nullable_to_non_nullable
as String?,lastVerifiedDate: freezed == lastVerifiedDate ? _self.lastVerifiedDate : lastVerifiedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as StorageLocation?,
  ));
}
/// Create a copy of ItemStorage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $StorageLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [ItemStorage].
extension ItemStoragePatterns on ItemStorage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemStorage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemStorage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemStorage value)  $default,){
final _that = this;
switch (_that) {
case _ItemStorage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemStorage value)?  $default,){
final _that = this;
switch (_that) {
case _ItemStorage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String itemId,  String storageLocationId,  String? containerType,  String? containerLabel,  String? slotEnvelopeNumber,  String? holderType,  String? environmentNotes,  DateTime? lastVerifiedDate,  String? notes,  DateTime? createdAt,  DateTime? updatedAt,  StorageLocation? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemStorage() when $default != null:
return $default(_that.id,_that.itemId,_that.storageLocationId,_that.containerType,_that.containerLabel,_that.slotEnvelopeNumber,_that.holderType,_that.environmentNotes,_that.lastVerifiedDate,_that.notes,_that.createdAt,_that.updatedAt,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String itemId,  String storageLocationId,  String? containerType,  String? containerLabel,  String? slotEnvelopeNumber,  String? holderType,  String? environmentNotes,  DateTime? lastVerifiedDate,  String? notes,  DateTime? createdAt,  DateTime? updatedAt,  StorageLocation? location)  $default,) {final _that = this;
switch (_that) {
case _ItemStorage():
return $default(_that.id,_that.itemId,_that.storageLocationId,_that.containerType,_that.containerLabel,_that.slotEnvelopeNumber,_that.holderType,_that.environmentNotes,_that.lastVerifiedDate,_that.notes,_that.createdAt,_that.updatedAt,_that.location);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String itemId,  String storageLocationId,  String? containerType,  String? containerLabel,  String? slotEnvelopeNumber,  String? holderType,  String? environmentNotes,  DateTime? lastVerifiedDate,  String? notes,  DateTime? createdAt,  DateTime? updatedAt,  StorageLocation? location)?  $default,) {final _that = this;
switch (_that) {
case _ItemStorage() when $default != null:
return $default(_that.id,_that.itemId,_that.storageLocationId,_that.containerType,_that.containerLabel,_that.slotEnvelopeNumber,_that.holderType,_that.environmentNotes,_that.lastVerifiedDate,_that.notes,_that.createdAt,_that.updatedAt,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ItemStorage implements ItemStorage {
  const _ItemStorage({this.id, required this.itemId, required this.storageLocationId, this.containerType, this.containerLabel, this.slotEnvelopeNumber, this.holderType, this.environmentNotes, this.lastVerifiedDate, this.notes, this.createdAt, this.updatedAt, this.location});
  factory _ItemStorage.fromJson(Map<String, dynamic> json) => _$ItemStorageFromJson(json);

@override final  String? id;
@override final  String itemId;
@override final  String storageLocationId;
@override final  String? containerType;
@override final  String? containerLabel;
@override final  String? slotEnvelopeNumber;
@override final  String? holderType;
@override final  String? environmentNotes;
@override final  DateTime? lastVerifiedDate;
@override final  String? notes;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  StorageLocation? location;

/// Create a copy of ItemStorage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemStorageCopyWith<_ItemStorage> get copyWith => __$ItemStorageCopyWithImpl<_ItemStorage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemStorageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemStorage&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.storageLocationId, storageLocationId) || other.storageLocationId == storageLocationId)&&(identical(other.containerType, containerType) || other.containerType == containerType)&&(identical(other.containerLabel, containerLabel) || other.containerLabel == containerLabel)&&(identical(other.slotEnvelopeNumber, slotEnvelopeNumber) || other.slotEnvelopeNumber == slotEnvelopeNumber)&&(identical(other.holderType, holderType) || other.holderType == holderType)&&(identical(other.environmentNotes, environmentNotes) || other.environmentNotes == environmentNotes)&&(identical(other.lastVerifiedDate, lastVerifiedDate) || other.lastVerifiedDate == lastVerifiedDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,storageLocationId,containerType,containerLabel,slotEnvelopeNumber,holderType,environmentNotes,lastVerifiedDate,notes,createdAt,updatedAt,location);

@override
String toString() {
  return 'ItemStorage(id: $id, itemId: $itemId, storageLocationId: $storageLocationId, containerType: $containerType, containerLabel: $containerLabel, slotEnvelopeNumber: $slotEnvelopeNumber, holderType: $holderType, environmentNotes: $environmentNotes, lastVerifiedDate: $lastVerifiedDate, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, location: $location)';
}


}

/// @nodoc
abstract mixin class _$ItemStorageCopyWith<$Res> implements $ItemStorageCopyWith<$Res> {
  factory _$ItemStorageCopyWith(_ItemStorage value, $Res Function(_ItemStorage) _then) = __$ItemStorageCopyWithImpl;
@override @useResult
$Res call({
 String? id, String itemId, String storageLocationId, String? containerType, String? containerLabel, String? slotEnvelopeNumber, String? holderType, String? environmentNotes, DateTime? lastVerifiedDate, String? notes, DateTime? createdAt, DateTime? updatedAt, StorageLocation? location
});


@override $StorageLocationCopyWith<$Res>? get location;

}
/// @nodoc
class __$ItemStorageCopyWithImpl<$Res>
    implements _$ItemStorageCopyWith<$Res> {
  __$ItemStorageCopyWithImpl(this._self, this._then);

  final _ItemStorage _self;
  final $Res Function(_ItemStorage) _then;

/// Create a copy of ItemStorage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? itemId = null,Object? storageLocationId = null,Object? containerType = freezed,Object? containerLabel = freezed,Object? slotEnvelopeNumber = freezed,Object? holderType = freezed,Object? environmentNotes = freezed,Object? lastVerifiedDate = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? location = freezed,}) {
  return _then(_ItemStorage(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,storageLocationId: null == storageLocationId ? _self.storageLocationId : storageLocationId // ignore: cast_nullable_to_non_nullable
as String,containerType: freezed == containerType ? _self.containerType : containerType // ignore: cast_nullable_to_non_nullable
as String?,containerLabel: freezed == containerLabel ? _self.containerLabel : containerLabel // ignore: cast_nullable_to_non_nullable
as String?,slotEnvelopeNumber: freezed == slotEnvelopeNumber ? _self.slotEnvelopeNumber : slotEnvelopeNumber // ignore: cast_nullable_to_non_nullable
as String?,holderType: freezed == holderType ? _self.holderType : holderType // ignore: cast_nullable_to_non_nullable
as String?,environmentNotes: freezed == environmentNotes ? _self.environmentNotes : environmentNotes // ignore: cast_nullable_to_non_nullable
as String?,lastVerifiedDate: freezed == lastVerifiedDate ? _self.lastVerifiedDate : lastVerifiedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as StorageLocation?,
  ));
}

/// Create a copy of ItemStorage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $StorageLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
