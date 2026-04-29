// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ItemImage _$ItemImageFromJson(Map<String, dynamic> json) => _ItemImage(
  id: json['id'] as String?,
  itemId: json['itemId'] as String,
  imageType: json['imageType'] as String,
  storagePath: json['storagePath'] as String,
  publicUrl: json['publicUrl'] as String?,
  isPublic: json['isPublic'] as bool? ?? false,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
  caption: json['caption'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ItemImageToJson(_ItemImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'imageType': instance.imageType,
      'storagePath': instance.storagePath,
      'publicUrl': instance.publicUrl,
      'isPublic': instance.isPublic,
      'displayOrder': instance.displayOrder,
      'caption': instance.caption,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
