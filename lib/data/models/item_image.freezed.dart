// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ItemImage {

 String? get id; String get itemId; String get imageType; String get storagePath; String? get publicUrl; bool get isPublic; int get displayOrder; String? get caption; DateTime? get createdAt;
/// Create a copy of ItemImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemImageCopyWith<ItemImage> get copyWith => _$ItemImageCopyWithImpl<ItemImage>(this as ItemImage, _$identity);

  /// Serializes this ItemImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemImage&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.imageType, imageType) || other.imageType == imageType)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.publicUrl, publicUrl) || other.publicUrl == publicUrl)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,imageType,storagePath,publicUrl,isPublic,displayOrder,caption,createdAt);

@override
String toString() {
  return 'ItemImage(id: $id, itemId: $itemId, imageType: $imageType, storagePath: $storagePath, publicUrl: $publicUrl, isPublic: $isPublic, displayOrder: $displayOrder, caption: $caption, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ItemImageCopyWith<$Res>  {
  factory $ItemImageCopyWith(ItemImage value, $Res Function(ItemImage) _then) = _$ItemImageCopyWithImpl;
@useResult
$Res call({
 String? id, String itemId, String imageType, String storagePath, String? publicUrl, bool isPublic, int displayOrder, String? caption, DateTime? createdAt
});




}
/// @nodoc
class _$ItemImageCopyWithImpl<$Res>
    implements $ItemImageCopyWith<$Res> {
  _$ItemImageCopyWithImpl(this._self, this._then);

  final ItemImage _self;
  final $Res Function(ItemImage) _then;

/// Create a copy of ItemImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? itemId = null,Object? imageType = null,Object? storagePath = null,Object? publicUrl = freezed,Object? isPublic = null,Object? displayOrder = null,Object? caption = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,imageType: null == imageType ? _self.imageType : imageType // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,publicUrl: freezed == publicUrl ? _self.publicUrl : publicUrl // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemImage].
extension ItemImagePatterns on ItemImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemImage value)  $default,){
final _that = this;
switch (_that) {
case _ItemImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemImage value)?  $default,){
final _that = this;
switch (_that) {
case _ItemImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String itemId,  String imageType,  String storagePath,  String? publicUrl,  bool isPublic,  int displayOrder,  String? caption,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemImage() when $default != null:
return $default(_that.id,_that.itemId,_that.imageType,_that.storagePath,_that.publicUrl,_that.isPublic,_that.displayOrder,_that.caption,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String itemId,  String imageType,  String storagePath,  String? publicUrl,  bool isPublic,  int displayOrder,  String? caption,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ItemImage():
return $default(_that.id,_that.itemId,_that.imageType,_that.storagePath,_that.publicUrl,_that.isPublic,_that.displayOrder,_that.caption,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String itemId,  String imageType,  String storagePath,  String? publicUrl,  bool isPublic,  int displayOrder,  String? caption,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ItemImage() when $default != null:
return $default(_that.id,_that.itemId,_that.imageType,_that.storagePath,_that.publicUrl,_that.isPublic,_that.displayOrder,_that.caption,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ItemImage implements ItemImage {
  const _ItemImage({this.id, required this.itemId, required this.imageType, required this.storagePath, this.publicUrl, this.isPublic = false, this.displayOrder = 0, this.caption, this.createdAt});
  factory _ItemImage.fromJson(Map<String, dynamic> json) => _$ItemImageFromJson(json);

@override final  String? id;
@override final  String itemId;
@override final  String imageType;
@override final  String storagePath;
@override final  String? publicUrl;
@override@JsonKey() final  bool isPublic;
@override@JsonKey() final  int displayOrder;
@override final  String? caption;
@override final  DateTime? createdAt;

/// Create a copy of ItemImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemImageCopyWith<_ItemImage> get copyWith => __$ItemImageCopyWithImpl<_ItemImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemImage&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.imageType, imageType) || other.imageType == imageType)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.publicUrl, publicUrl) || other.publicUrl == publicUrl)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemId,imageType,storagePath,publicUrl,isPublic,displayOrder,caption,createdAt);

@override
String toString() {
  return 'ItemImage(id: $id, itemId: $itemId, imageType: $imageType, storagePath: $storagePath, publicUrl: $publicUrl, isPublic: $isPublic, displayOrder: $displayOrder, caption: $caption, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ItemImageCopyWith<$Res> implements $ItemImageCopyWith<$Res> {
  factory _$ItemImageCopyWith(_ItemImage value, $Res Function(_ItemImage) _then) = __$ItemImageCopyWithImpl;
@override @useResult
$Res call({
 String? id, String itemId, String imageType, String storagePath, String? publicUrl, bool isPublic, int displayOrder, String? caption, DateTime? createdAt
});




}
/// @nodoc
class __$ItemImageCopyWithImpl<$Res>
    implements _$ItemImageCopyWith<$Res> {
  __$ItemImageCopyWithImpl(this._self, this._then);

  final _ItemImage _self;
  final $Res Function(_ItemImage) _then;

/// Create a copy of ItemImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? itemId = null,Object? imageType = null,Object? storagePath = null,Object? publicUrl = freezed,Object? isPublic = null,Object? displayOrder = null,Object? caption = freezed,Object? createdAt = freezed,}) {
  return _then(_ItemImage(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,imageType: null == imageType ? _self.imageType : imageType // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,publicUrl: freezed == publicUrl ? _self.publicUrl : publicUrl // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
