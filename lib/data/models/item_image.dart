import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_image.freezed.dart';
part 'item_image.g.dart';

@freezed
sealed class ItemImage with _$ItemImage {
  const factory ItemImage({
    String? id,
    required String itemId,
    required String imageType,
    required String storagePath,
    String? publicUrl,
    @Default(false) bool isPublic,
    @Default(0) int displayOrder,
    String? caption,
    DateTime? createdAt,
  }) = _ItemImage;

  factory ItemImage.fromJson(Map<String, dynamic> json) =>
      _$ItemImageFromJson(json);
}
